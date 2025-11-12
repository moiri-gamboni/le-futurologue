# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SvelteKit-based landing page for "Le Futurologue", a French AI podcast and conference speaker service by Shaïman Thürler. The site showcases conference offerings, media appearances, stats, and provides a contact form for booking.

**Technology Stack:**
- SvelteKit with Svelte 5 (runes syntax)
- TypeScript
- mdsvex for Markdown-based content authoring
- Netlify adapter for deployment
- pnpm package manager

**Design Philosophy:**
This site was systematically designed using principles from *Refactoring UI* by Steve Schoger and Adam Wathan. Every design decision—from the color palette to spacing to component hierarchy—follows deliberate, documented principles rather than arbitrary choices. See `docs/design-plan.md` for the complete 1850-line design specification including all Refactoring UI principles applied.

**Brand Identity:**
- **Colors**: Green (#4ada56) for growth/technology, Yellow (#fae60b) for energy/innovation
- **Personality**: The Sage/Explorer archetype - expert knowledge made accessible
- **Visual Language**: Dark backgrounds (premium), sans-serif typography (approachable), 8px radius (modern professionalism)
- **Target Feeling**: "This is a serious expert who makes complex topics accessible and engaging"

## Commands

```bash
# Development
pnpm run dev              # Start dev server
pnpm run dev -- --open    # Start dev server and open browser

# Production
pnpm run build            # Build for production (used by Netlify)
pnpm run preview          # Preview production build

# Code Quality
pnpm run check            # Run svelte-check (type checking)
pnpm run check:watch      # Run svelte-check in watch mode
pnpm run lint             # Run ESLint and Prettier checks
pnpm run format           # Format code with Prettier
```

## Architecture

### Content Strategy: mdsvex

The site uses **mdsvex** to enable Markdown-based content authoring with embedded Svelte components:

- **Main page**: `src/routes/+page.svx` - Written in Markdown with imported Svelte components
- **Configuration**: `svelte.config.js` includes `mdsvex()` preprocessor
- **Supported extensions**: `.svelte` (standard components), `.svx` (mdsvex pages)
- **Pattern**: Content-heavy pages authored in Markdown can seamlessly embed interactive Svelte components

### Component Architecture

Components follow Svelte 5's modern patterns with a clear separation between layout and functional components:

**Layout Components** (accept content via snippets):
- `Hero` - Full-screen hero with background image
- `Section` - Themed section container with optional fade-in animation
- `TwoColumn` - Responsive two-column layout with configurable image position

**Functional Components** (configured via props):
- `Button` - Primary/secondary button variants, renders as `<a>` or `<button>`
- `ContactForm` - Form with Netlify Forms integration, client-side state management using `$state` rune
- `MediaGrid` - YouTube video grid with thumbnails and play buttons
- `LogoCarousel` - Infinite scrolling logo carousel with animation
- `StatsBar` - Statistics display with responsive grid
- `SocialLinks` - Social media link grid with text-based icons

**Props Pattern** (all components use this):
```typescript
interface Props {
  variant?: 'primary' | 'secondary';
  children?: import('svelte').Snippet;
}
let { variant = 'primary', children }: Props = $props();
```

**Snippet Pattern** (for content injection):
```svelte
{@render children?.()}
```

### Styling System

Custom design system defined in `src/lib/styles/variables.css` following Refactoring UI principles:

- **Colors**: `--dark-*` (900-300), `--green-*` (brand accent, 900-100), `--yellow-*` (secondary accent), `--grey-*` (blue-tinted)
- **Typography**: Hand-picked scale `--text-xs` through `--text-5xl`, weights, line-heights
- **Spacing**: Linear 4px-based scale `--space-1` through `--space-32`
- **Shadows**: Two-part realistic shadows `--shadow-sm` through `--shadow-xl`
- **Containers**: `--container-sm` (600px) through `--container-xl` (1200px)
- **Breakpoints**: `--breakpoint-sm` (640px) through `--breakpoint-2xl` (1440px)
- **Borders**: `--radius-sm` through `--radius-full`
- **Transitions**: `--transition-fast/base/slow`
- **Z-index**: `--z-base` through `--z-toast`

**Key Refactoring UI Principles Applied:**

1. **Color System** (variables.css:1-148):
   - *"Don't let lightness kill saturation"*: Lighter/darker shades increase saturation to stay vibrant
   - *"Greys don't have to be grey"*: Blue-tinted greys for warmth (not pure 0% saturation)
   - *"Hue rotation for brightness"*: Darker yellows rotate toward orange to avoid muddy brown
   - Full 9-shade palette defined upfront for each color

2. **Typography** (variables.css:55-78, global.css:9-58):
   - *"Hand-picked sizes, not ratios"*: Each size chosen for purpose (not mathematical 1.5x scale)
   - *"Line-height varies by use"*: Tight (1.1) for headings, relaxed (1.7) for body
   - Letter-spacing: -2% for large headings, +5% for uppercase labels
   - Font: Inter (modern, legible, tech-appropriate without being technical)

3. **Spacing** (variables.css:80-95):
   - *"Start with too much whitespace"*: 5rem (80px) section padding feels generous
   - *"Avoid ambiguous spacing"*: Related elements closer than unrelated (label 0.5rem from input, 2rem to next group)
   - Linear 4px-based scale (not exponential)

4. **Shadows** (variables.css:97-108):
   - *"Two-part shadows"*: Larger soft shadow + smaller dark shadow = realistic depth
   - *"Emulate light from above"*: All shadows have downward offset
   - Used sparingly: buttons only, not all cards (dark/light section alternation provides depth)

5. **Visual Hierarchy** (global.css throughout, component styles):
   - *"Emphasize by de-emphasizing"*: Stats labels smaller/lighter so numbers pop
   - *"Don't use grey on colored backgrounds"*: `rgba(255,255,255,0.7)` instead of grey color
   - *"Balance weight and contrast"*: Bold text uses lighter colors

**Global Styles** (`src/lib/styles/global.css`):
- Applies design system to HTML elements
- Typography base (Inter font family)
- Responsive heading sizes
- Link, list, blockquote, code styling
- Accessibility features (focus styles, reduced motion support)
- Utility classes (`.sr-only`, `.container-*`)
- Custom scrollbar styling

**Reset** (`src/lib/styles/reset.css`):
- Modern CSS reset
- Accessibility considerations (reduced motion)

### Animation System

**Fade-in on Scroll** (`src/lib/utils/fade-in.ts`):
- Svelte action using Intersection Observer API
- Options: delay, duration, threshold, once
- Respects `prefers-reduced-motion`
- Used by `Section` component with `animate` prop

### Form Handling

**Contact Form Flow**:
1. Component: `src/lib/components/ContactForm.svelte`
   - Uses Svelte 5's `$state` rune for form state management
   - States: `'idle' | 'submitting' | 'success' | 'error'`
   - Client-side fetch to submit form
   - Honeypot field for spam prevention
2. Server action: `src/routes/+page.server.ts` (currently logs to console, TODO: integrate email service)
3. **Netlify Forms**: Configured via HTML attributes (`data-netlify="true"`, `netlify-honeypot="bot-field"`)
   - Form submissions handled by Netlify platform
   - No additional backend required

### Deployment

**Netlify Configuration**:
- Adapter: `@sveltejs/adapter-netlify` (configured in `svelte.config.js`)
- Build command: `pnpm run build` (specified in `netlify.toml`)
- Publish directory: `build`
- Netlify Forms enabled for contact form

## File Structure Patterns

```
src/
├── lib/
│   ├── components/        # All Svelte components
│   ├── styles/            # Design system (variables, reset, global)
│   ├── utils/             # Utilities (fade-in action)
│   ├── assets/            # Imported assets (favicon)
│   └── index.ts           # (empty, for $lib alias)
├── routes/
│   ├── +layout.svelte     # Root layout (fonts, favicon)
│   ├── +page.svx          # Main page (mdsvex)
│   └── +page.server.ts    # Server-side form action
└── app.d.ts               # TypeScript types

static/
├── images/                # Public images
│   └── logos/             # Logo placeholders (SVG)
└── robots.txt
```

## Code Style

**Prettier Configuration** (`.prettierrc`):
- Tabs (not spaces)
- Single quotes
- No trailing commas
- 100 character print width
- Svelte plugin enabled

**ESLint Configuration** (`eslint.config.js`):
- Extends recommended configs for JS, TypeScript, Svelte
- Integrates with Prettier
- `no-undef` disabled (handled by TypeScript)
- TypeScript parser for Svelte files

## Important Implementation Details

1. **Svelte 5 Runes**: Project uses modern Svelte 5 syntax
   - `$props()` for component props
   - `$state()` for reactive state
   - `{@render snippet()}` for content projection

2. **Accessibility**: All components include:
   - Proper ARIA labels
   - Focus-visible styles
   - Reduced motion support
   - Screen reader-only content (`.sr-only`)

3. **Responsive Design**: Mobile-first approach
   - Components have responsive breakpoints
   - Typography scales for mobile
   - Grid layouts adapt to screen size
   - **Refactoring UI principle**: *"Relative sizing doesn't scale"* - each breakpoint hand-adjusted (hero 5rem → 3rem = 40% reduction, not proportional 60%)
   - **Refactoring UI principle**: *"You don't have to fill the whole screen"* - contact form stays 600px max even on large screens
   - **Refactoring UI principle**: *"Don't shrink until you need to"* - elements maintain optimal size as long as viewport allows

4. **Performance Considerations**:
   - Lazy loading images (`loading="lazy"`)
   - Intersection Observer for scroll animations
   - CSS transitions with reduced motion fallbacks

5. **Placeholder Images**: Current images in `/static/images/` are SVG placeholders
   - Logo placeholders: `placeholder-1.svg` through `placeholder-4.svg`
   - Photo placeholders: `.placeholder.svg` files (actual photos pending)

## Current Implementation Status

**⚠️ IMPORTANT:** This site is ~70% launch-ready. Several features marked complete in the original plan are not actually implemented.

**Critical Blockers:**
1. **All images are SVG placeholders** - Need real conference photos and client logos
2. **Missing social platforms** - Threads and Discord not in page (present in design brief)
3. **No analytics** - Cannot track conversions

**See:** `docs/implementation-audit.md` for detailed audit findings

**What Works:**
- ✅ All 9 core components functional
- ✅ Complete design system (colors, typography, spacing, shadows)
- ✅ Scroll animations, responsive design, accessibility
- ✅ Netlify Forms integration
- ✅ Mobile-first responsive breakpoints

**What's Missing:**
- ❌ Real images (all are placeholder SVGs)
- ❌ Video hero background (marked done but not implemented)
- ❌ Image optimization (WebP, srcset)
- ❌ Analytics integration
- ❌ Performance audit
- ❌ Text highlight effects (SVG underlines)

## Design Documentation

**Primary Reference**: `docs/design-plan.md` (1850 lines)
- Complete design system specifications with HSL values
- All Refactoring UI principles applied with explanations
- Component specifications with visual diagrams
- Responsive strategy with breakpoint-specific decisions
- Brand personality definition and visual translation
- Implementation phases (MVP → Enhanced → Polish → Future)
- **NOW INCLUDES:** Current implementation status at top

**Implementation Audit**: `docs/implementation-audit.md` (Created 2025-11-07)
- Line-by-line verification of design-plan.md checkboxes
- What's actually complete vs marked complete
- Priority issues and recommendations
- Launch readiness assessment (70%)

**Client Requirements**: `docs/design-brief.md`
- Original client info and content
- Brand colors: Green #4ada56, Yellow #fae60b
- Reference sites for inspiration
- Social media links and contact info

## Content Editing Guide

The main page (`src/routes/+page.svx`) is written in Markdown with embedded Svelte components. This makes it easy to update content without touching component code.

**Updating Text**: Edit Markdown directly in `+page.svx`
**Updating Stats**: Find `<StatsBar stats={[...]}` and modify values
**Adding Videos**: Find `<MediaGrid videos={[...]}` and add `{ id: "YOUTUBE_ID", title: "..." }`
**Changing Images**: Replace files in `static/images/` and update paths in components

## Design Decision Philosophy

When making changes to this site, understand that every visual choice was deliberate:

- **8px border radius** = approachable professionalism (not 0px cold, not 20px+ playful)
- **Green primary color** = growth, future, technology (perfect for AI topic)
- **Dark/light section alternation** = creates depth without heavy shadows
- **Generous whitespace** = premium feel, not cramped
- **Hand-picked typography scale** = each size serves specific purpose
- **Two-part shadows** = realistic elevation (large soft + small dark)

Don't arbitrarily change these values. If adjustments are needed, reference `docs/design-plan.md` to understand the principle behind the original choice, then adjust systematically across the entire design system.


## Available MCP Tools:

You are able to use the Svelte MCP server, where you have access to comprehensive Svelte 5 and SvelteKit documentation. Here's how to use the available tools effectively:

### 1. list-sections

Use this FIRST to discover all available documentation sections. Returns a structured list with titles, use_cases, and paths.
When asked about Svelte or SvelteKit topics, ALWAYS use this tool at the start of the chat to find relevant sections.

### 2. get-documentation

Retrieves full documentation content for specific sections. Accepts single or multiple sections.
After calling the list-sections tool, you MUST analyze the returned documentation sections (especially the use_cases field) and then use the get-documentation tool to fetch ALL documentation sections that are relevant for the user's task.

### 3. svelte-autofixer

Analyzes Svelte code and returns issues and suggestions.
You MUST use this tool whenever writing Svelte code before sending it to the user. Keep calling it until no issues or suggestions are returned.

### 4. playground-link (do not use)