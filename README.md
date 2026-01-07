# Le Futurologue

Conference speaker website for **Shaïman Thürler**, AI specialist and founder of Le Futurologue - the leading French-language podcast on artificial intelligence.

Built with SvelteKit, Tailwind CSS v4, and shadcn-svelte components following [Refactoring UI](https://www.refactoringui.com/) design principles.

## Features

- 🎨 **Comprehensive design system** - 34 hand-picked color shades with saturation compensation
- 🧩 **shadcn-svelte components** - Pre-built, accessible UI components
- 📱 **Mobile-first responsive** - Hand-picked breakpoints (not percentage-based)
- ⚡ **Svelte 5** - Modern runes and snippets architecture
- 🖼️ **Optimized images** - Vite asset imports with automatic optimization
- 🎯 **Single-page design** - Smooth scrolling, clear CTAs
- ♿ **Accessible** - ARIA labels, focus states, keyboard navigation
- 🚀 **Cloudflare Workers** - Optimized for edge deployment with global distribution

## Tech Stack

- **Framework:** [SvelteKit](https://svelte.dev/) (Svelte 5)
- **Styling:** [Tailwind CSS v4](https://tailwindcss.com/)
- **Components:** [shadcn-svelte](https://www.shadcn-svelte.com/)
- **Icons:** [Lucide Svelte](https://lucide.dev/)
- **Deployment:** [Cloudflare Workers](https://workers.cloudflare.com/) (`adapter-cloudflare`)

## Getting Started

### Prerequisites

- Node.js 18+
- pnpm (recommended) or npm

### Installation

```bash
# Install dependencies
pnpm install

# Start development server
pnpm run dev

# Open in browser at http://localhost:5173
```

### Development Commands

```bash
pnpm run dev          # Start dev server
pnpm run build        # Build for production
pnpm run preview      # Preview production build
pnpm run check        # Type check (run before committing!)
pnpm run lint         # Lint with ESLint + Prettier
pnpm run format       # Format code with Prettier
```

## Project Structure

```
src/
├── lib/
│   ├── assets/
│   │   ├── images/      # Photos (imported via Vite)
│   │   └── logos/       # Client logos
│   └── components/
│       ├── ui/          # shadcn-svelte components
│       ├── Section.svelte
│       ├── SectionHeading.svelte
│       └── FormField.svelte
├── routes/
│   └── +page.svelte     # Main landing page
└── app.css              # Complete design system
```

## Design System Highlights

### Color Palette

The design system uses **34 carefully crafted shades** following Refactoring UI principles:

- **Dark backgrounds:** `--dark-900` to `--dark-300` (pure greys)
- **Green accent (brand):** `--green-900` to `--green-100` - `--green-500` is primary CTA
- **Yellow accent:** `--yellow-900` to `--yellow-100` - `--yellow-500` is secondary
- **Blue-tinted greys:** `--grey-900` to `--grey-100` - subtle warmth, NOT pure grey

**Key principles:**
1. ✨ Saturation increases at lightness extremes (prevents washed-out/muddy colors)
2. 🎨 Greys have blue undertone (warmer, more professional)
3. 🌈 Darker yellows rotate toward orange (avoids muddy brown)

### Typography & Spacing

- **Border radius:** 8px everywhere for approachable professionalism
- **Spacing:** 4px-based linear scale (not geometric)
- **Typography:** Hand-picked sizes, not mathematical ratios
- **Responsive:** Large elements shrink faster than small elements

See `docs/design-plan.md` for complete specifications.

## Key Conventions

### Svelte 5 Patterns

This project uses **Svelte 5 runes** (not Svelte 4 patterns):

```svelte
<!-- State management -->
<script>
  let count = $state(0);              // NOT: let count = 0
  let doubled = $derived(count * 2);  // NOT: $: doubled = count * 2
</script>

<!-- Props in components -->
<script>
  interface Props {
    theme?: 'light' | 'dark';
    children: Snippet;
  }

  let { theme = 'light', children }: Props = $props();
</script>

<!-- Always use keys in #each -->
{#each items as item (item.id)}  <!-- Required! -->
  ...
{/each}
```

### Component Architecture

Three reusable wrappers eliminate code repetition:

```svelte
<!-- Section wrapper -->
<Section theme="dark" width="lg" padding="md">
  <SectionHeading>My Heading</SectionHeading>
  <!-- Content -->
</Section>

<!-- Form fields -->
<FormField
  id="email"
  name="email"
  type="email"
  label="Email"
  required
/>
```

### Image Imports

All images imported from `$lib/assets/` for Vite optimization:

```typescript
import heroImage from '$lib/assets/images/hero.jpeg';

<img src={heroImage} alt="..." />
<div style="background-image: url({heroImage});"></div>
```

## Deployment

Configured for **Cloudflare Workers** deployment:

### Using Git Integration

1. Go to Cloudflare Dashboard > Workers & Pages
2. Create or select your Worker
3. Go to Settings > Builds > Git integration
4. Connect your GitHub/GitLab repository
5. Configure build settings:
   - **Build command:** `pnpm run build`
   - **Build output directory:** `.svelte-kit/cloudflare`

### Using Wrangler CLI

```bash
# Build the project
pnpm run build

# Deploy to Cloudflare Workers
wrangler deploy
```

### Form Handling

Forms require server-side handling via SvelteKit form actions. See [SvelteKit form actions documentation](https://svelte.dev/docs/kit/form-actions) for details.

## Documentation

- **For developers:** See [CLAUDE.md](./CLAUDE.md) for detailed architecture and conventions
- **Design specifications:** See [docs/design-plan.md](./docs/design-plan.md)
- **Design brief:** See [docs/design-brief.md](./docs/design-brief.md)

## Adding shadcn-svelte Components

```bash
npx shadcn-svelte@latest add [component-name]
```

Currently installed: `accordion`, `aspect-ratio`, `avatar`, `badge`, `button`, `card`, `carousel`, `input`, `label`, `separator`, `sonner`, `textarea`

## License

Private project © 2025 Le Futurologue
