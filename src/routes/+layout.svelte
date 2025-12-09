<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicons/favicon.png';
	import appleTouchIcon from '$lib/assets/favicons/apple-touch-icon.png';
	import openGraphImage from '$lib/assets/images/open-graph.jpg';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" type="image/png" href={favicon} />
	<link rel="apple-touch-icon" href={appleTouchIcon} />

	<!-- Open Graph -->
	<meta property="og:title" content="Shaïman Thürler - Conférencier spécialiste en IA" />
	<meta property="og:description" content="Conférences claires, accessibles et rigoureuses sur les enjeux de l'intelligence artificielle." />
	<meta property="og:url" content="https://lefuturologue.com" />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Le Futurologue" />
	<meta property="og:locale" content="fr_FR" />
	<meta property="og:image" content={openGraphImage} />
	<meta property="og:image:width" content="1200" />
	<meta property="og:image:height" content="630" />

	<!-- Twitter -->
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:image" content={openGraphImage} />
	<meta name="twitter:title" content="Shaïman Thürler - Conférencier spécialiste en IA" />
	<meta name="twitter:description" content="Conférences claires, accessibles et rigoureuses sur les enjeux de l'intelligence artificielle." />
	<meta name="twitter:site" content="@le_futurologue" />
	<meta name="twitter:creator" content="@le_futurologue" />

	<!-- Canonical -->
	<link rel="canonical" href="https://lefuturologue.com" />

	<!-- Structured Data -->
	{@html `<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "@id": "https://lefuturologue.com/#website",
      "url": "https://lefuturologue.com",
      "name": "Le Futurologue",
      "description": "Site officiel de Shaïman Thürler, conférencier spécialiste en intelligence artificielle",
      "publisher": {
        "@id": "https://lefuturologue.com/#person"
      },
      "inLanguage": "fr-FR"
    },
    {
      "@type": "Person",
      "@id": "https://lefuturologue.com/#person",
      "name": "Shaïman Thürler",
      "alternateName": "Le Futurologue",
      "jobTitle": "Conférencier spécialiste en intelligence artificielle",
      "description": "Conférences sur l'intelligence artificielle, le futur du travail et les enjeux technologiques. Fondateur du plus grand podcast francophone sur l'IA.",
      "url": "https://lefuturologue.com",
      "image": "${openGraphImage}",
      "knowsAbout": [
        "Intelligence artificielle",
        "IA générative",
        "ChatGPT",
        "Futur du travail",
        "Transformation digitale",
        "Innovation technologique",
        "Éthique de l'IA"
      ],
      "sameAs": [
        "https://youtube.com/@lefuturologuepodcast",
        "https://instagram.com/le.futurologue",
        "https://linkedin.com/in/shaimanthurler",
        "https://twitter.com/le_futurologue",
        "https://facebook.com/le.futurologue",
        "https://tiktok.com/@le.futurologue",
        "https://threads.net/@le.futurologue",
        "https://bsky.app/profile/lefuturologue.bsky.social",
        "https://mastodon.social/@le_futurologue"
      ]
    },
    {
      "@type": "PodcastSeries",
      "@id": "https://lefuturologue.com/#podcast",
      "name": "Le Futurologue",
      "description": "Le plus grand podcast francophone sur l'intelligence artificielle",
      "url": "https://youtube.com/@lefuturologuepodcast",
      "author": {
        "@id": "https://lefuturologue.com/#person"
      },
      "inLanguage": "fr-FR"
    }
  ]
}
</script>`}

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
