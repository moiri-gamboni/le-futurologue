<script lang="ts">
	import wordmarkCream from '$lib/assets/brand/wordmark-cream.png';
	import wordmarkBurgundy from '$lib/assets/brand/wordmark-burgundy.png';
	import wordmarkGradient from '$lib/assets/brand/wordmark-gradient.png';
	import logoTete from '$lib/assets/brand/logo-tete.png';

	type Variant = 'wordmark-cream' | 'wordmark-burgundy' | 'wordmark-gradient' | 'logo-tete';

	interface Props {
		variant: Variant;
		class?: string;
		alt?: string;
		priority?: boolean;
	}

	let {
		variant,
		class: className = '',
		alt = 'Le Futurologue',
		priority = false
	}: Props = $props();

	const assets: Record<Variant, string> = {
		'wordmark-cream': wordmarkCream,
		'wordmark-burgundy': wordmarkBurgundy,
		'wordmark-gradient': wordmarkGradient,
		'logo-tete': logoTete
	};
</script>

<img
	src={assets[variant]}
	{alt}
	class={className}
	loading={priority ? 'eager' : 'lazy'}
	fetchpriority={priority ? 'high' : 'auto'}
	decoding="async"
/>
