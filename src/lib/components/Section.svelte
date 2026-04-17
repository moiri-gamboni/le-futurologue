<script lang="ts">
	import { type Snippet } from 'svelte';

	interface Props {
		theme?: 'cream' | 'burgundy' | 'peach';
		width?: 'sm' | 'md' | 'lg' | 'xl';
		padding?: 'sm' | 'md' | 'lg';
		grain?: boolean;
		id?: string;
		class?: string;
		children: Snippet;
	}

	let {
		theme = 'cream',
		width = 'lg',
		padding = 'lg',
		grain = false,
		id,
		class: className = '',
		children
	}: Props = $props();

	const bgClass = {
		cream: 'bg-background',
		burgundy: 'bg-red-900',
		peach: 'bg-gradient-soft'
	}[theme];

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

<section
	{id}
	class="relative {bgClass} {paddingClasses[padding]} {grain ? 'grain' : ''} {className}"
>
	<div class="relative z-10 mx-auto {widthClasses[width]} px-8">
		{@render children()}
	</div>
</section>
