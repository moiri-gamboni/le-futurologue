<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicons/favicon.png';
	import appleTouchIcon from '$lib/assets/favicons/apple-touch-icon.png';

	let { children, data } = $props();
</script>

<svelte:head>
	<link rel="icon" type="image/png" href={favicon} />
	<link rel="apple-touch-icon" href={appleTouchIcon} />

	<!-- Open Graph -->
	<meta property="og:title" content="Shaïman Thürler - Conférencier spécialiste en IA" />
	<meta
		property="og:description"
		content="Conférences claires, accessibles et rigoureuses sur les enjeux de l'intelligence artificielle."
	/>
	<meta property="og:url" content="https://lefuturologue.com" />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Le Futurologue" />
	<meta property="og:locale" content="fr_FR" />
	<meta property="og:image" content={data.openGraphImage} />
	<meta property="og:image:width" content="1200" />
	<meta property="og:image:height" content="630" />

	<!-- Twitter -->
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:image" content={data.openGraphImage} />
	<meta name="twitter:title" content="Shaïman Thürler - Conférencier spécialiste en IA" />
	<meta
		name="twitter:description"
		content="Conférences claires, accessibles et rigoureuses sur les enjeux de l'intelligence artificielle."
	/>
	<meta name="twitter:site" content="@le_futurologue" />
	<meta name="twitter:creator" content="@le_futurologue" />

	<!-- Canonical -->
	<link rel="canonical" href="https://lefuturologue.com" />

	<!-- JSON-LD structured data (assembled in +layout.ts, injected verbatim). -->
	{@html data.ldScript}

	<!-- Preload critical brand fonts for optimal performance -->
	<link
		rel="preload"
		href="/fonts/metropolis/metropolis-regular.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
	<link
		rel="preload"
		href="/fonts/metropolis/metropolis-bold.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
	<link
		rel="preload"
		href="/fonts/squanova/squanova-regular.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
</svelte:head>

{@render children()}
