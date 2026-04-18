import openGraphImage from '$lib/assets/images/open-graph.jpg';

export const load = () => {
	const structuredData = {
		'@context': 'https://schema.org',
		'@graph': [
			{
				'@type': 'WebSite',
				'@id': 'https://lefuturologue.com/#website',
				url: 'https://lefuturologue.com',
				name: 'Le Futurologue',
				description:
					'Site officiel de Shaïman Thürler, conférencier spécialiste en intelligence artificielle',
				publisher: { '@id': 'https://lefuturologue.com/#person' },
				inLanguage: 'fr-FR'
			},
			{
				'@type': 'Person',
				'@id': 'https://lefuturologue.com/#person',
				name: 'Shaïman Thürler',
				alternateName: 'Le Futurologue',
				jobTitle: 'Conférencier spécialiste en intelligence artificielle',
				description:
					"Conférences sur l'intelligence artificielle, le futur du travail et les enjeux technologiques. Fondateur du plus grand podcast francophone sur l'IA.",
				url: 'https://lefuturologue.com',
				image: openGraphImage,
				knowsAbout: [
					'Intelligence artificielle',
					'IA générative',
					'ChatGPT',
					'Futur du travail',
					'Transformation digitale',
					'Innovation technologique',
					"Éthique de l'IA"
				],
				sameAs: [
					'https://youtube.com/@lefuturologuepodcast',
					'https://instagram.com/le.futurologue',
					'https://linkedin.com/in/shaimanthurler',
					'https://twitter.com/le_futurologue',
					'https://facebook.com/le.futurologue',
					'https://tiktok.com/@le.futurologue',
					'https://threads.net/@le.futurologue',
					'https://bsky.app/profile/lefuturologue.bsky.social',
					'https://mastodon.social/@le_futurologue'
				]
			},
			{
				'@type': 'PodcastSeries',
				'@id': 'https://lefuturologue.com/#podcast',
				name: 'Le Futurologue',
				description: "Le plus grand podcast francophone sur l'intelligence artificielle",
				url: 'https://youtube.com/@lefuturologuepodcast',
				author: { '@id': 'https://lefuturologue.com/#person' },
				inLanguage: 'fr-FR'
			}
		]
	};

	// Escape `<` so nothing in the payload can terminate the <script> early.
	const payload = JSON.stringify(structuredData).replace(/</g, '\\u003c');
	const ldScript = `<script type="application/ld+json">${payload}</script>`;

	return { ldScript, openGraphImage };
};
