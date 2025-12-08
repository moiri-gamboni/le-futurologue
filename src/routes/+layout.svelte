<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicons/favicon.png';
	import appleTouchIcon from '$lib/assets/favicons/apple-touch-icon.png';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" type="image/png" href={favicon} />
	<link rel="apple-touch-icon" href={appleTouchIcon} />

	<!-- Preload critical fonts for optimal performance -->
	<!-- Eliminates 670ms render-blocking delay from Google Fonts CDN -->
	<link
		rel="preload"
		href="/fonts/inter-v20-latin/inter-v20-latin-regular.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
	<link
		rel="preload"
		href="/fonts/inter-v20-latin/inter-v20-latin-600.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
	<link
		rel="preload"
		href="/fonts/space-grotesk-v22-latin/space-grotesk-v22-latin-700.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
</svelte:head>

{@render children()}
