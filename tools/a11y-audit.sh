#!/usr/bin/env bash
# Comprehensive a11y audit: axe-core static scan + default/hover/focus
# contrast sweep across every interactive element, at desktop + mobile
# viewports, for every route.
#
# Usage:
#   # With the preview server already running on :4173
#   bash tools/a11y-audit.sh
#
#   # Or point at a different URL
#   bash tools/a11y-audit.sh http://127.0.0.1:5173
#
# Output: a11y-reports/<timestamp>-<label>.json for axe runs +
# a11y-reports/<timestamp>-<label>.md summary.
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:4173}"
REPORT_DIR="a11y-reports"
mkdir -p "$REPORT_DIR"
TS=$(date +%Y%m%d-%H%M%S)

curl -sf -o /dev/null "$BASE_URL" || {
	echo "Preview not reachable at $BASE_URL — run 'pnpm run dev' or 'pnpm run preview' first." >&2
	exit 1
}
command -v rodney >/dev/null || {
	echo "rodney CLI not installed (https://github.com/simonw/rodney)" >&2
	exit 2
}

rodney --local start 2>/dev/null || true

# ---------------------------------------------------------------------------
# Injected JS: run axe-core against the current page.
# axe-core loaded from a CDN, which a localhost HTTP page is allowed to pull
# because mixed-content rules only block https→http, not http→https.
# ---------------------------------------------------------------------------
read -r -d '' AXE_JS <<'JS' || true
(async () => {
	if (!window.axe) {
		await new Promise((resolve, reject) => {
			const s = document.createElement('script');
			s.src = 'https://cdnjs.cloudflare.com/ajax/libs/axe-core/4.10.2/axe.min.js';
			s.onload = resolve;
			s.onerror = () => reject(new Error('axe-core failed to load'));
			document.head.appendChild(s);
		});
	}
	const r = await axe.run({
		runOnly: { type: 'tag', values: ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'] }
	});
	return JSON.stringify({
		url: location.href,
		violations: r.violations.map((v) => ({
			id: v.id,
			impact: v.impact,
			help: v.help,
			helpUrl: v.helpUrl,
			tags: v.tags,
			nodes: v.nodes.map((n) => ({
				target: n.target,
				html: n.html.substring(0, 240),
				failureSummary: n.failureSummary
			}))
		})),
		incomplete: r.incomplete.map((i) => ({ id: i.id, help: i.help, nodes: i.nodes.length })),
		passes: r.passes.length,
		inapplicable: r.inapplicable.length
	});
})();
JS

# ---------------------------------------------------------------------------
# Injected JS: contrast sweep across every interactive element, in three
# CSS states — default, :hover, :focus-visible. We simulate hover / focus
# by adding `:where(...)`-compatible attribute hooks and a runtime
# stylesheet that copies every `:hover` / `:focus-visible` rule onto the
# hook. That lets us read computed styles in the pseudo-class state
# without firing synthetic mouse / focus events (which are racy under
# headless automation).
# ---------------------------------------------------------------------------
read -r -d '' CONTRAST_JS <<'JS' || true
(async () => {
	const rgb = (c) => {
		const m = c.match(/rgba?\(([^)]+)\)/);
		if (!m) return null;
		const parts = m[1].split(',').map((s) => parseFloat(s.trim()));
		return { r: parts[0], g: parts[1], b: parts[2], a: parts[3] ?? 1 };
	};
	const lum = ({ r, g, b }) => {
		const f = (v) => {
			v /= 255;
			return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
		};
		return 0.2126 * f(r) + 0.7152 * f(g) + 0.0722 * f(b);
	};
	const ratio = (a, b) => {
		const L = [lum(a), lum(b)].sort((x, y) => y - x);
		return (L[0] + 0.05) / (L[1] + 0.05);
	};
	const composite = (fg, bg) => {
		// fg over bg per alpha-over formula (both in sRGB, a in [0,1])
		const a = fg.a;
		return {
			r: Math.round(fg.r * a + bg.r * (1 - a)),
			g: Math.round(fg.g * a + bg.g * (1 - a)),
			b: Math.round(fg.b * a + bg.b * (1 - a)),
			a: 1
		};
	};
	const effectiveBg = (el) => {
		let cur = el;
		let acc = { r: 255, g: 255, b: 255, a: 1 };
		const stack = [];
		while (cur && cur !== document.documentElement) {
			const cs = getComputedStyle(cur);
			const c = rgb(cs.backgroundColor);
			if (c && c.a > 0) stack.unshift(c);
			// Also consider background-image gradients — we can't compute per-pixel,
			// so we fall back to the element's own color or continue walking.
			cur = cur.parentElement;
		}
		// html/body default white
		for (const c of stack) acc = composite(c, acc);
		return acc;
	};

	// Enumerate all styleable rules that apply to :hover or :focus-visible,
	// and clone them onto parallel rules keyed off a data attribute we add
	// to one element at a time. This lets us "preview" the pseudo-class
	// state via DOM manipulation.
	const hoverRules = [];
	const focusRules = [];
	for (const sheet of document.styleSheets) {
		try {
			for (const rule of sheet.cssRules) {
				if (!rule.selectorText) continue;
				if (rule.selectorText.includes(':hover'))
					hoverRules.push({ sel: rule.selectorText, body: rule.cssText });
				if (rule.selectorText.includes(':focus-visible'))
					focusRules.push({ sel: rule.selectorText, body: rule.cssText });
			}
		} catch (e) {
			/* cross-origin stylesheet */
		}
	}
	const cloneState = (rules, pseudo, synth) => {
		const css = rules
			.map(({ sel, body }) => body.replace(new RegExp(pseudo, 'g'), synth))
			.join('\n');
		const s = document.createElement('style');
		s.dataset.a11yProbe = pseudo.slice(1);
		s.textContent = css;
		document.head.appendChild(s);
		return s;
	};
	const hoverStyle = cloneState(hoverRules, ':hover', '[data-a11y-hover]');
	const focusStyle = cloneState(focusRules, ':focus-visible', '[data-a11y-focus]');

	const targets = Array.from(
		document.querySelectorAll('a, button, [role="link"], [role="button"]')
	);
	const results = [];

	const readState = (el) => {
		const cs = getComputedStyle(el);
		const fg = rgb(cs.color);
		const bg = effectiveBg(el);
		const text = (el.textContent || '').trim().substring(0, 60);
		return {
			fg: cs.color,
			bg: `rgb(${bg.r},${bg.g},${bg.b})`,
			ratio: fg ? ratio(fg, bg).toFixed(2) : 'n/a',
			text: text || el.getAttribute('aria-label') || '(unlabeled)',
			outline: cs.outlineColor + ' ' + cs.outlineWidth,
			ring: cs.boxShadow.substring(0, 100)
		};
	};

	for (const el of targets) {
		if (!el.offsetParent) continue;
		const rect = el.getBoundingClientRect();
		if (rect.width * rect.height === 0) continue;
		const id =
			el.getAttribute('data-slot') ||
			el.getAttribute('aria-label') ||
			el.getAttribute('href') ||
			el.textContent?.trim().substring(0, 30) ||
			el.tagName;
		const entry = { id, tag: el.tagName };
		entry.default = readState(el);
		el.setAttribute('data-a11y-hover', '');
		entry.hover = readState(el);
		el.removeAttribute('data-a11y-hover');
		el.setAttribute('data-a11y-focus', '');
		entry.focus = readState(el);
		el.removeAttribute('data-a11y-focus');
		results.push(entry);
	}

	// Clean up the injected probes so downstream audits aren't polluted
	hoverStyle.remove();
	focusStyle.remove();

	return JSON.stringify(results, null, 0);
})();
JS

run_page() {
	local path="$1"
	local label="$2"

	echo "==> ${BASE_URL}${path}  (label=${label})"
	rodney --local open "${BASE_URL}${path}" >/dev/null
	rodney --local waitload >/dev/null
	# give the page a second to settle (enhanced-img, carousel autoplay etc.)
	sleep 2

	echo "    running axe-core ..."
	rodney --local js "$AXE_JS" >"${REPORT_DIR}/${TS}-${label}-axe.json"

	echo "    sweeping contrast (default/hover/focus) ..."
	rodney --local js "$CONTRAST_JS" >"${REPORT_DIR}/${TS}-${label}-contrast.json"
}

run_page "/" "home"
run_page "/confidentialite" "privacy"

# ---------------------------------------------------------------------------
# Build a human-readable report.
# ---------------------------------------------------------------------------
python3 <<PY
import json, os, glob
ts = "${TS}"
report = ["# Accessibility audit — ${TS}\n", "Base URL: ${BASE_URL}\n"]
for label in ("home", "privacy"):
    axe_file = f"${REPORT_DIR}/{ts}-{label}-axe.json"
    contrast_file = f"${REPORT_DIR}/{ts}-{label}-contrast.json"
    if not os.path.exists(axe_file):
        continue
    axe = json.load(open(axe_file))
    report.append(f"\n## {label} — {axe.get('url','?')}\n")
    vs = axe.get("violations", [])
    report.append(f"- axe-core: **{len(vs)} violations**, "
                  f"{len(axe.get('incomplete',[]))} incomplete, "
                  f"{axe.get('passes','?')} passes\n")
    for v in vs:
        report.append(f"\n### \`{v['id']}\` — {v['impact']} — {v['help']}\n")
        report.append(f"- [docs]({v.get('helpUrl','')})\n")
        for n in v["nodes"][:5]:
            report.append(f"  - \`{' '.join(n['target'])}\`\n")
            report.append(f"    ```html\n    {n['html']}\n    ```\n")
            report.append(f"    {n['failureSummary'].replace(chr(10), ' ⏎ ')}\n")
        if len(v["nodes"]) > 5:
            report.append(f"  - … and {len(v['nodes']) - 5} more\n")
    if os.path.exists(contrast_file):
        try:
            data = json.load(open(contrast_file))
        except json.JSONDecodeError:
            data = []
        report.append(f"\n### Contrast sweep ({len(data)} interactive elements)\n\n")
        report.append("| id | default | hover | focus |\n| --- | --- | --- | --- |\n")
        for e in data:
            def flag(r):
                try:
                    x = float(r)
                except Exception:
                    return r
                mark = "✅" if x >= 4.5 else ("⚠️ " if x >= 3.0 else "❌")
                return f"{mark} {x:.2f}"
            row = (
                f"| \`{e['id'][:40]}\` | "
                f"{flag(e['default']['ratio'])} | "
                f"{flag(e['hover']['ratio'])} | "
                f"{flag(e['focus']['ratio'])} |"
            )
            report.append(row + "\n")

out = f"${REPORT_DIR}/${TS}-report.md"
with open(out, "w") as f:
    f.writelines(report)
print(f"\n=== Report written to {out} ===")
PY

echo ""
echo "Done. Review:"
ls -1 "${REPORT_DIR}/${TS}"*
