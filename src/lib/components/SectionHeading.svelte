<script lang="ts">
	import { type Snippet } from 'svelte';

	interface Props {
		level?: 'h1' | 'h2' | 'h3';
		theme?: 'cream' | 'burgundy' | 'peach';
		class?: string;
		children: Snippet;
	}

	let { level = 'h2', theme = 'cream', class: className = '', children }: Props = $props();

	const textColor = {
		cream: 'text-foreground',
		burgundy: 'text-warm-100',
		peach: 'text-foreground'
	}[theme];
	const baseClasses = `mb-12 text-center text-3xl font-bold ${textColor} md:text-4xl ${className}`;
</script>

<svelte:element this={level} class={baseClasses}>
	{@render children()}
</svelte:element>
