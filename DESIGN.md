# Le Futurologue — Design System

Reference for contributors building or editing pages. The single source of truth for tokens is `src/app.css`.

## Palette — two scales, 17 primitives

Brand-named swatches (red, burgundy, peach, cream) are anchors on two hue families, not four independent ramps. See `src/app.css` header for full oklch values.

### Red scale (saturated accent)

Hue anchored 10–27°, chroma peaks at 500.

| Token     | Hex       | Role                                                |
| --------- | --------- | --------------------------------------------------- |
| `red-100` | ≈ #fcd4d5 | Soft pink — banner bg, disabled-tint                |
| `red-300` | ≈ #f7797f | Muted red — disabled state                          |
| `red-500` | `#e30713` | **Brand anchor** — primary CTA, signal              |
| `red-700` | `#420318` | **Brand anchor** — burgundy foreground, focus ring  |
| `red-900` | `#2b0212` | **Brand anchor** — gradient-A dark end, burgundy bg |

### Warm scale (low-chroma neutral; hue rotates 10→45→15)

| Token      | Hex       | Role                                       |
| ---------- | --------- | ------------------------------------------ |
| `warm-50`  | ≈ #fff7f5 | Near-white                                 |
| `warm-100` | `#ffebeb` | **Brand anchor** — cream, default light bg |
| `warm-200` | `#f7e7df` | **Brand anchor** — gradient-B light end    |
| `warm-300` | `#f9c2a4` | **Brand anchor** — peach, accent surface   |
| `warm-500` | ≈ #c68670 | Terracotta divider on cream                |
| `warm-700` | ≈ #6e2a28 | Subtle warm-dark on cream                  |

### Gradients

- `--gradient-hero` (vertical `red-500 → red-900`) — signature brand treatment. Utility: `.bg-gradient-hero`.
- `--gradient-hero-diagonal` (135°) — logo backgrounds.
- `--gradient-hero-radial` — radial variant for profile/spotlight surfaces.
- `--gradient-soft` (135° `warm-300 → warm-200`) — soft peach gradient for warm sections. Utility: `.bg-gradient-soft`.

## Contrast matrix

Document WCAG contrast for every foreground/background pairing the site actually uses. **Never place red on burgundy for small text.** **Never place peach on cream for text in any size.**

| FG                 | BG                 | Contrast | Grade    | Notes                                                      |
| ------------------ | ------------------ | -------: | -------- | ---------------------------------------------------------- |
| `warm-100` cream   | `red-700` burgundy |    ~14:1 | AAA      | Default section text on burgundy                           |
| `warm-100` cream   | `red-900`          |    ~17:1 | AAA      | Deepest burgundy, strongest contrast                       |
| `warm-100` cream   | `red-500`          |   ~5.6:1 | AA       | Large text only (≥18 pt); use for CTA label                |
| `warm-300` peach   | `red-700`          |   ~8.8:1 | AAA      | Stats numbers, peach on burgundy                           |
| `warm-300` peach   | `red-900`          |   ~9.4:1 | AAA      | Same, deeper bg                                            |
| `red-500` red      | `warm-100` cream   |   ~4.8:1 | AA       | Body links ≥14 pt; small text should use `red-700` instead |
| `red-700` burgundy | `warm-100` cream   |    ~14:1 | AAA      | Default foreground on cream                                |
| `red-700` burgundy | `warm-300` peach   |   ~8.7:1 | AAA      |                                                            |
| `red-500` red      | `red-700` burgundy |   ~2.9:1 | **FAIL** | Never for small text. Graphic elements only.               |
| `warm-300` peach   | `warm-100` cream   |   ~1.3:1 | **FAIL** | Never for text. Decorative surfaces only.                  |

## Typography

- **Body / UI** — Metropolis (SIL OFL). `font-sans` token. Weights shipped: 400, 400 italic, 500, 700.
- **Display** — Squanova (permissive per original A25-Squanova author statement, confirmed with designer). `font-display` token. Used on all `h1–h6` and `.font-display` elements. **Uppercase-only by design** — lowercase input renders as uppercase. Glyph coverage is Basic Latin + Latin-1 Supplement + smart quotes + Euro; missing codepoints (U+202F, Œ/œ, en/em dashes) fall through to Metropolis via the `unicode-range` in `@font-face`.

### Type scale (hand-picked, not mathematical)

```
--text-xs:   12px  / 16      (captions)
--text-sm:   14px  / 20      (meta, helper text)
--text-base: 16px  / 1.6     (body)
--text-lg:   18px  / 1.5     (larger body)
--text-xl:   20px  / 1.4
--text-2xl:  24px  / 1.3
--text-3xl:  30px  / 1.2     (h3)
--text-4xl:  40px  / 1.1     (h2)
--text-5xl:  60px  / 1       (hero h1)
--text-6xl:  80px  / 0.95    (wordmark moments)
```

## Shadows — emulate light from above

Tints are burgundy-rgba, not neutral black, so shadows integrate with the warm palette.

```
--shadow-sm:   0 1px 2px 0 rgb(43 2 18 / 0.08)
--shadow:      0 2px 4px 0 rgb(43 2 18 / 0.10)
--shadow-md:   0 4px 6px -1px rgb(43 2 18 / 0.12), 0 2px 4px -2px rgb(43 2 18 / 0.08)
--shadow-lg:   0 12px 16px -4px rgb(43 2 18 / 0.18), 0 4px 6px -4px rgb(43 2 18 / 0.10)
--shadow-cta:  0 8px 24px -4px rgb(43 2 18 / 0.35)   ← reserved for red CTA
```

The red CTA uses `shadow-cta` because a red-tinted shadow on cream reads muddy; burgundy-tinted shadow keeps the CTA visually grounded.

## Signature utility classes

Defined in `@layer utilities` in `src/app.css`.

- `.bg-gradient-hero` / `.bg-gradient-hero-diagonal` / `.bg-gradient-hero-radial` — background-image utilities for Gradient A.
- `.bg-gradient-soft` — Gradient B utility.
- `.text-gradient-hero` — gradient-clipped text (uses background-clip: text with `-webkit-` fallback).
- `.border-gradient-hero` — 2-pixel Gradient A border via the `linear-gradient padding-box, gradient border-box` trick. Used on the hero CTA.
- `.grain` — adds an inline-SVG fractal-noise overlay at 5% opacity via `::before`. Apply to burgundy sections for atmospheric texture.
- `.rise` — CSS-only page-load stagger animation (opacity + translateY). Children set `style="--delay: Nms"` to sequence the reveal. Wrapped in `prefers-reduced-motion: no-preference`.

## Components

- `Section` — theme prop is `'cream' | 'burgundy' | 'peach'`. Other props: `width`, `padding`, `grain`, `decoration` (Snippet positioned absolutely outside the max-width wrapper — use for bleeding-art moments).
- `SectionHeading` — same theme union.
- `Logo` — discriminated-union variant: `'wordmark-cream' | 'wordmark-burgundy' | 'wordmark-gradient' | 'logo-tete'`. Use `priority` for above-the-fold.
- Shadcn ui/\* components re-skin automatically via the preserved `--primary`, `--background`, `--foreground` etc. semantic contract. Do not edit them.

## Usage rules

1. **Never** place red on burgundy for small text. Red at `≥18 pt bold` only, or as graphic elements.
2. **Never** place peach on cream for text of any size.
3. **Default ring color** is `var(--red-700)` burgundy, not red, so focus rings stay visible on red CTAs.
4. **CTA shadows** always use `shadow-cta` (burgundy-tinted). Do not tint shadows with red.
5. **Stagger children** with `.rise` + `--delay` increments of 120 ms for orchestrated page loads; don't sprinkle micro-interactions.
6. **One asymmetric moment** per page. The current page's moment is the About-section logo-tête bleeding off the right edge.
7. **Grain overlay** only on burgundy sections. Do not apply to cream or peach.

## Fonts on disk

Subsetted woff2 under `static/fonts/`:

```
static/fonts/metropolis/
├── metropolis-regular.woff2        ~10 KB
├── metropolis-regular-italic.woff2 ~11 KB
├── metropolis-medium.woff2         ~10 KB
├── metropolis-bold.woff2           ~10 KB
└── LICENSE.txt                     SIL OFL

static/fonts/squanova/
└── squanova-regular.woff2          ~6 KB
```

Regenerate with `scripts/subset-fonts.sh` (requires `uv`).

## Brand assets

Under `src/lib/assets/brand/`:

```
wordmark-cream.png       cream flat wordmark, transparent bg (dark contexts)
wordmark-burgundy.png    burgundy flat wordmark, transparent bg (footer, light contexts)
wordmark-gradient.png    Gradient A wordmark, transparent bg
logo-tete.png            Gradient A head illustration, transparent bg (About section asymmetric moment)
```

All cropped tight + 3% padding. Regenerate via the staging workflow in `plans/rebrand.md`.

Photography lives in `src/lib/assets/images/` and is processed through `@sveltejs/enhanced-img` to produce responsive AVIF/WebP/JPEG variants at build time.
