<script lang="ts">
	import { type Snippet } from 'svelte';

	interface Props {
		theme?: 'light' | 'dark';
		width?: 'sm' | 'md' | 'lg' | 'xl';
		padding?: 'sm' | 'md' | 'lg';
		id?: string;
		children: Snippet;
	}

	let { theme = 'light', width = 'lg', padding = 'lg', id, children }: Props = $props();

	const bgClass = theme === 'dark' ? 'bg-dark-800' : 'bg-background';

	const widthClasses = {
		sm: 'max-w-2xl',
		md: 'max-w-4xl',
		lg: 'max-w-6xl',
		xl: 'max-w-7xl'
	};

	const paddingClasses = {
		sm: 'py-12 md:py-16',
		md: 'py-16 md:py-20',
		lg: 'py-16 md:py-20'
	};
</script>

<section {id} class="{bgClass} {paddingClasses[padding]}">
	<div class="mx-auto {widthClasses[width]} px-8">
		{@render children()}
	</div>
</section>
