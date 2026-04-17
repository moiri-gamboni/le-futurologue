<script lang="ts">
	import { type Snippet } from 'svelte';

	interface Props {
		theme?: 'cream' | 'burgundy' | 'peach';
		width?: 'sm' | 'md' | 'lg' | 'xl';
		padding?: 'sm' | 'md' | 'lg';
		grain?: boolean;
		id?: string;
		class?: string;
		/** Absolute-positioned decoration rendered outside the max-width wrapper (use for bleeding art). */
		decoration?: Snippet;
		children: Snippet;
	}

	let {
		theme = 'cream',
		width = 'lg',
		padding = 'lg',
		grain = false,
		id,
		class: className = '',
		decoration,
		children
	}: Props = $props();

	const bgClass = $derived(
		{
			cream: 'bg-background',
			burgundy: 'bg-red-900',
			peach: 'bg-gradient-soft'
		}[theme]
	);

	const widthClass = $derived(
		{
			sm: 'max-w-2xl',
			md: 'max-w-4xl',
			lg: 'max-w-6xl',
			xl: 'max-w-7xl'
		}[width]
	);

	const paddingClass = $derived(
		{
			sm: 'py-12 md:py-16',
			md: 'py-16 md:py-20',
			lg: 'py-16 md:py-20'
		}[padding]
	);
</script>

<section {id} class="relative {bgClass} {paddingClass} {grain ? 'grain' : ''} {className}">
	{#if decoration}
		{@render decoration()}
	{/if}
	<div class="relative z-10 mx-auto {widthClass} px-8">
		{@render children()}
	</div>
</section>
