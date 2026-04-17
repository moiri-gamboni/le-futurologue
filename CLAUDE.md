# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Conference speaker website for Shaïman Thürler (Le Futurologue) - AI specialist and podcast host. Single-page SvelteKit application with a comprehensive design system based on Refactoring UI principles.

**Tech Stack:**

- SvelteKit (Svelte 5 with runes and snippets)
- Tailwind CSS v4
- shadcn-svelte components
- Cloudflare Workers deployment (adapter-cloudflare)

**Reference Documentation:**

- `DESIGN.md` — current design system spec (palette, typography, contrast matrix, signature utilities, usage rules).
- `plans/rebrand.md` — April 2026 rebrand implementation plan.
- `artistic-direction/analysis.md` — brand asset analysis + decisions that shaped the current system.

## Development Commands

```bash
# Development
pnpm run dev                # Start dev server
pnpm run check              # Type check without watch
pnpm run check:watch        # Type check with watch mode

# Code Quality
pnpm run lint               # Run ESLint + Prettier check
pnpm run format             # Format code with Prettier

# Production
pnpm run build              # Build for production
pnpm run preview            # Preview production build
```

**Important:** Always run `pnpm run check` before committing to ensure TypeScript and Svelte compilation succeed.

## Architecture

### Design System (app.css + DESIGN.md)

The entire design system lives in `src/app.css` with **17 primitives on two hue families**, following Refactoring UI principles. See `DESIGN.md` for the full contrast matrix, type scale, and usage rules.

**Palette — 2 scales, not 4:**

- **Red scale (saturated accent):** `red-100 / 300 / 500 / 700 / 900`. Anchors: `red-500 = #e30713` (CTA), `red-700 = #420318` (burgundy), `red-900 = #2b0212` (gradient-A dark end, burgundy bg).
- **Warm scale (low-chroma neutral, hue rotates 10→45→15):** `warm-50 / 100 / 200 / 300 / 500 / 700`. Anchors: `warm-100 = #ffebeb` (cream, default bg), `warm-200 = #f7e7df` (gradient-B light), `warm-300 = #f9c2a4` (peach).
- **Gradient A (signature):** `linear-gradient(180deg, red-500 → red-900)`. Utilities: `.bg-gradient-hero`, `.bg-gradient-hero-diagonal`, `.bg-gradient-hero-radial`, `.text-gradient-hero`, `.border-gradient-hero`.
- **Gradient B (soft):** `linear-gradient(135deg, warm-300 → warm-200)`. Utility: `.bg-gradient-soft`.

**Shadcn semantic contract preserved** (no edits to `ui/*` needed):

- `--primary: red-500`, `--primary-foreground: warm-100`
- `--background: warm-100`, `--foreground: red-700`
- `--accent: warm-300`, `--ring: red-700` (burgundy, not red, so focus rings stay visible on red CTAs)
- `--destructive: oklch(0.5 0.22 18)` (darker than brand red, distinguishable for form errors)

**Typography:**

- Body / UI: **Metropolis** (SIL OFL; Regular, Italic, Medium, Bold self-hosted in `static/fonts/metropolis/`). Accessed via `--font-sans` / `font-sans`.
- Display: **Squanova** (original A25-Squanova is permissive per author; confirmed with designer). Uppercase-only by design. Accessed via `--font-display` / `font-display`.
- Hand-picked type scale: 12/14/16/18/20/24/30/40/60/80 px (see `DESIGN.md`).

**Shadow tokens** are **burgundy-tinted** rgba (not neutral black) so they integrate with the warm palette. Red CTAs use `--shadow-cta` specifically — red-tinted shadow on cream reads muddy.

**Border Radius:** 8px everywhere (`--radius: 0.5rem`).

**Signature utilities** in `@layer utilities`: `.grain` (inline-SVG fractal-noise overlay at 5% opacity, apply to burgundy sections), `.rise` (CSS-only page-load stagger with `--delay` inline style, respects `prefers-reduced-motion`).

**Usage:** Use Tailwind utilities like `bg-red-900`, `text-warm-100`, `border-warm-500`, `bg-primary`, `text-foreground`. For derived states prefer shadcn semantic tokens (`bg-primary/10`, `text-foreground/75`) over raw scale tokens. **Never** pair red on burgundy for small text. **Never** pair peach on cream for text.

### Component Architecture

Four reusable wrapper components eliminate repetition:

**Section.svelte** — Standardized section wrapper

```svelte
<Section
	theme="cream|burgundy|peach"
	width="sm|md|lg|xl"
	padding="sm|md|lg"
	grain={true | false}
	id="contact"
	class="overflow-hidden"
	decoration={mySnippet}
>
	<!-- Content -->
</Section>
```

- `theme`: `cream` (bg-background), `burgundy` (bg-red-900), or `peach` (bg-gradient-soft).
- `grain`: adds fractal-noise overlay on burgundy sections.
- `decoration`: a `Snippet` rendered absolutely OUTSIDE the max-width wrapper, for bleeding-art moments (e.g. the About-section logo-tête).

**SectionHeading.svelte** — Consistent headings

```svelte
<SectionHeading level="h2|h3" theme="cream|burgundy|peach">Heading text</SectionHeading>
```

**Logo.svelte** — Brand mark with typed variant API

```svelte
<Logo
	variant="wordmark-cream|wordmark-burgundy|wordmark-gradient|logo-tete"
	alt="Le Futurologue"
	priority={true | false}
	class="h-8 w-auto"
/>
```

- Variants are a discriminated union — invalid values fail at compile time.
- Use `priority` for above-the-fold rendering (sets `loading="eager"` + `fetchpriority="high"`).

**FormField.svelte** — Form fields with labels

```svelte
<FormField
	id="email"
	name="email"
	type="text|email|textarea"
	label="Email"
	placeholder="..."
	required
/>
```

**Pattern:** Keep components simple and focused. Complex layouts stay in `+page.svelte`.

### Image Imports

All images imported from `$lib/assets/` for Vite optimization:

```typescript
import heroImage from '$lib/assets/images/hero.jpeg';
import logoVyv from '$lib/assets/logos/groupe-vyv.svg';

// Usage in templates
<img src={heroImage} alt="..." />
<section style="background-image: url({heroImage});">
```

**Benefits:** Automatic optimization, cache busting, type safety, build-time validation.

**Naming Convention:** Use semantic, descriptive filenames (e.g., `hero.jpeg`, `profile.jpeg`) instead of camera-generated names (e.g., `IMG_8029.jpeg`).

### Svelte 5 Patterns

This project uses **Svelte 5 runes and snippets** (not Svelte 4 patterns):

**State Management:**

```typescript
let count = $state(0); // NOT: let count = 0
let doubled = $derived(count * 2); // NOT: $: doubled = count * 2
```

**Props (components):**

```typescript
interface Props {
	theme?: 'cream' | 'burgundy' | 'peach';
	children: Snippet; // For slot content
}

let { theme = 'cream', children }: Props = $props();
```

**Rendering snippets:**

```svelte
{@render children()}
```

**Keys in #each blocks:** Always required in Svelte 5:

```svelte
{#each items as item (item.id)}  <!-- Must have key -->
```

### shadcn-svelte Integration

Components installed: `accordion`, `aspect-ratio`, `avatar`, `badge`, `button`, `card`, `carousel`, `input`, `label`, `separator`, `textarea`

**Adding new components:**

```bash
npx shadcn-svelte@latest add [component-name]
```

**Usage pattern:**

```svelte
import {Button} from '$lib/components/ui/button'; import * as Card from '$lib/components/ui/card'; //
Namespace imports for multi-part

<Button variant="outline" size="lg">Click me</Button>

<Card.Root>
	<Card.Header>
		<Card.Title>Title</Card.Title>
	</Card.Header>
	<Card.Content>Content</Card.Content>
</Card.Root>
```

**Theming:** Components use CSS variables from `app.css`. Do not override with inline styles.

## Key Conventions

### Data Structure with IDs

All arrays must have `id` fields for Svelte 5 keys:

```typescript
const stats = [
  { id: 'videos', value: '180+', label: 'vidéos' },  // ✅ Has id
  { id: 'followers', value: '80K+', label: 'abonnés' }
];

{#each stats as stat (stat.id)}  <!-- Use id as key -->
```

### French Accents

Always use proper French accents:

- ✅ conférence, spécialiste, vidéos, abonnés, écoutes
- ❌ conference, specialiste, videos, abonnes, ecoutes

### Responsive Design

Mobile-first with hand-picked breakpoints (not percentage-based):

- Desktop headings: `text-3xl md:text-4xl` (not `text-[120%]`)
- Sections: `py-16 md:py-20` (not proportional scaling)

**Principle:** Large elements shrink faster than small elements for comfortable proportions.

### DRY Principle

Before adding repetitive code:

1. Check if `Section`, `SectionHeading`, or `FormField` can handle it
2. If pattern repeats 3+ times, extract to a component
3. Add proper TypeScript types and Svelte 5 `$props()`

## Type Checking

**Before committing:** Run `pnpm run check` and ensure **0 errors, 0 warnings**.

Common issues:

- Missing keys in `#each` blocks
- Using Svelte 4 patterns instead of runes
- Incorrect prop types in components

## Deployment

Configured for Cloudflare Workers (`adapter-cloudflare`).

**Build Settings:**

- Build command: `pnpm run build`
- Deploy command: `wrangler deploy`
- Build output directory: `.svelte-kit/cloudflare`

**Git Integration:**
Workers supports automatic deployments from GitHub/GitLab. Configure via Cloudflare Dashboard > Workers & Pages > Settings > Builds > Git integration.

**Manual Deployment:**

```bash
pnpm run build
wrangler deploy
```

**Form Handling:**
Form submissions require server-side handling via SvelteKit form actions in `+page.server.js` files. See the contact form implementation in `src/routes/+page.svelte`.

**Local Development:**
The adapter emulates Cloudflare's platform during development. Use `pnpm run dev` for development, or test the production build with:

- `wrangler dev` (after running `pnpm run build`)

**Environment Variables:**
Secrets must be set via Wrangler or Cloudflare Dashboard:

```bash
wrangler secret put RESEND_API_KEY
```

Or via Dashboard: Worker > Settings > Variables and Secrets. This project uses `$env/static/private` for secrets (build-time strategy).
