# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Conference speaker website for Shaïman Thürler (Le Futurologue) - AI specialist and podcast host. Single-page SvelteKit application with a comprehensive design system based on Refactoring UI principles.

**Tech Stack:**
- SvelteKit (Svelte 5 with runes and snippets)
- Tailwind CSS v4
- shadcn-svelte components
- Cloudflare Workers deployment (adapter-cloudflare)

**Reference Documentation:** `docs/design-plan.md` contains the complete design system specification and component requirements.

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

### Design System (app.css)

The entire design system lives in `src/app.css` with **34 hand-picked color shades** following Refactoring UI principles:

**Color System:**
- Dark backgrounds: `--dark-900` through `--dark-300` (7 shades, pure greys)
- Green accent (brand): `--green-900` through `--green-100` (9 shades) - `--green-500` is primary CTA
- Yellow accent: `--yellow-900` through `--yellow-100` (9 shades) - `--yellow-500` is secondary
- Blue-tinted greys: `--grey-900` through `--grey-100` (9 shades) - **NOT pure grey**, subtle blue undertone for warmth

**Key Principles Applied:**
1. **Don't let lightness kill saturation** - Extreme shades have higher saturation to maintain vibrancy
2. **Greys aren't grey** - Blue tint (saturation 0.01 not 0) for professional, tech-appropriate feel
3. **Hue rotation** - Darker yellows rotate toward orange to avoid muddy brown

**Border Radius:** 8px everywhere (`--radius: 0.5rem`) for approachable professionalism

**Usage:** Use Tailwind utilities like `bg-dark-800`, `text-green-500`, `border-grey-300`. Avoid creating new color variables.

### Component Architecture

Three reusable wrapper components eliminate repetition:

**Section.svelte** - Standardized section wrapper
```svelte
<Section theme="light|dark" width="sm|md|lg|xl" padding="sm|md|lg" id="contact">
  <!-- Content -->
</Section>
```
- Handles background colors, max-width constraints, and vertical padding
- Replaces 8+ repeated section patterns

**SectionHeading.svelte** - Consistent headings
```svelte
<SectionHeading level="h2|h3" theme="light|dark">
  Heading text
</SectionHeading>
```

**FormField.svelte** - Form fields with labels
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
let count = $state(0);              // NOT: let count = 0
let doubled = $derived(count * 2);  // NOT: $: doubled = count * 2
```

**Props (components):**
```typescript
interface Props {
  theme?: 'light' | 'dark';
  children: Snippet;  // For slot content
}

let { theme = 'light', children }: Props = $props();
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

Components installed: `accordion`, `aspect-ratio`, `avatar`, `badge`, `button`, `card`, `carousel`, `input`, `label`, `separator`, `sonner`, `textarea`

**Adding new components:**
```bash
npx shadcn-svelte@latest add [component-name]
```

**Usage pattern:**
```svelte
import { Button } from '$lib/components/ui/button';
import * as Card from '$lib/components/ui/card';  // Namespace imports for multi-part

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
