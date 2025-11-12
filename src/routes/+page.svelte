<script>
	import Hero from '$lib/components/Hero.svelte';
	import Section from '$lib/components/Section.svelte';
	import StatsBar from '$lib/components/StatsBar.svelte';
	import LogoCarousel from '$lib/components/LogoCarousel.svelte';
	import MediaGrid from '$lib/components/MediaGrid.svelte';
	import TwoColumn from '$lib/components/TwoColumn.svelte';
	import Button from '$lib/components/Button.svelte';
	import ContactForm from '$lib/components/ContactForm.svelte';
	import SocialLinks from '$lib/components/SocialLinks.svelte';

	import heroImage from '$lib/assets/images/IMG_7197.jpeg?enhanced';
	import conferenceImage from '$lib/assets/images/IMG_8028.jpeg?enhanced';

	import logoVYV from '$lib/assets/logos/groupe-vyv.svg';
	import logoREC from '$lib/assets/logos/rec.webp';
	import logoAEF from '$lib/assets/logos/aef.png';
	import logoEurekafe from '$lib/assets/logos/eurekafe.png';
</script>

<svelte:head>
	<title>Shaïman Thürler - Conférencier spécialiste en intelligence artificielle</title>
	<meta
		name="description"
		content="Conférencier spécialiste en IA. Plus grand podcast francophone sur l'intelligence artificielle. Conférences adaptables, pédagogiques et approfondies."
	/>
</svelte:head>

<Hero background={heroImage}>
	<h1>Shaïman Thürler</h1>
	<h2>Conférencier spécialiste en intelligence artificielle</h2>
	<Button href="#contact">Me contacter</Button>
</Hero>

<StatsBar
	stats={[
		{ value: '180+', label: 'vidéos' },
		{ value: '80K+', label: 'abonnés' },
		{ value: '170K+', label: 'écoutes/mois' }
	]}
/>

<Section theme="light">
	<LogoCarousel
		logos={[
			{ src: logoVYV, alt: 'Groupe VYV' },
			{ src: logoREC, alt: "Rencontres de l'Esprit Critique" },
			{ src: logoAEF, alt: 'Altruisme Efficace France' },
			{ src: logoEurekafe, alt: 'Eurêkafé' }
		]}
	/>
</Section>

<Section theme="light" width="xl">
	<TwoColumn
		image={conferenceImage}
		imagePosition="left"
		imageAlt="Shaïman Thürler en conférence"
	>
		<h2>Ma conférence</h2>

		<p>
			Ma conférence la plus demandée explore <strong
				>le futur et les dangers de l'intelligence artificielle</strong
			>. Elle offre un panorama clair et accessible de la trajectoire dans laquelle nous sommes
			embarqués.
		</p>

		<ul>
			<li><strong>Durée:</strong> Adaptable de 15 min à 3h</li>
			<li><strong>Lieu:</strong> En présentiel (France & international) ou en visio</li>
			<li><strong>Format:</strong> Pédagogique, approfondi, constructif</li>
		</ul>

		<Button href="#contact">Réserver une conférence</Button>
	</TwoColumn>
</Section>

<Section theme="dark">
	<h2>Qui suis-je ?</h2>

	<p>
		Je suis le fondateur du média <strong>Le Futurologue</strong>, le plus grand podcast
		francophone sur l'intelligence artificielle.
	</p>

	<p>
		À travers des interviews, des débats et des analyses, mon objectif est d'expliquer les enjeux
		de l'IA de façon simple et rigoureuse. J'ai eu le privilège d'échanger avec des dizaines
		d'experts de premier plan et de donner de nombreuses conférences et interventions publiques.
	</p>

	<Button variant="secondary" href="https://youtube.com/@lefuturologuepodcast">
		Voir ma chaîne YouTube →
	</Button>
</Section>

<Section theme="light">
	<h2>Thèmes de conférences</h2>

	<h3>Conférence principale</h3>

	<p>
		<strong>Le futur et les dangers de l'intelligence artificielle</strong> - Un panorama clair et
		accessible de la trajectoire dans laquelle nous sommes embarqués. Point de départ idéal pour
		comprendre les vrais enjeux derrière le battage médiatique.
	</p>

	<h3>Autres interventions possibles</h3>

	<ul>
		<li>Le futur du travail</li>
		<li>Les enjeux géopolitiques de l'IA</li>
		<li>La souveraineté numérique</li>
		<li>La robotique</li>
		<li>Les impacts psychologiques de l'IA</li>
		<li>Thèmes sur mesure selon vos besoins</li>
	</ul>
</Section>

<Section theme="dark">
	<h2>Conférences & Interviews</h2>

	<h3>Exemples de conférences réalisées</h3>

	<MediaGrid
		videos={[
			{ id: 'yusjUh-2a7E', title: 'TransVision 2022' },
			{ id: 'xnBLgKEs9aM', title: 'Rencontres Esprit Critique' },
			{ id: 'sCRh9Pd8z_k', title: 'Altruisme Efficace France' }
		]}
	/>

	<h3>Interviews données</h3>

	<MediaGrid
		videos={[
			{ id: 'yusjUh-2a7E', title: 'Interview - TransVision' },
			{ id: 'xnBLgKEs9aM', title: 'Interview - Esprit Critique' },
			{ id: 'sCRh9Pd8z_k', title: 'Interview - Altruisme Efficace' }
		]}
	/>
</Section>

<Section theme="light">
	<div id="contact">
		<h2>Me contacter</h2>

		<ContactForm />

		<p><strong>Email:</strong> contact@lefuturologue.com</p>

		<h3>Retrouvez-moi sur les réseaux sociaux</h3>

		<SocialLinks
			platforms={[
				{ name: 'YouTube', url: 'https://youtube.com/@lefuturologuepodcast' },
				{ name: 'Instagram', url: 'https://instagram.com/le.futurologue' },
				{ name: 'LinkedIn', url: 'https://linkedin.com/in/shaimanthurler' },
				{ name: 'Twitter/X', url: 'https://twitter.com/le_futurologue' },
				{ name: 'Facebook', url: 'https://facebook.com/le.futurologue' },
				{ name: 'TikTok', url: 'https://tiktok.com/@le.futurologue' },
				{ name: 'Bluesky', url: 'https://bsky.app/profile/lefuturologue.bsky.social' },
				{ name: 'Mastodon', url: 'https://mastodon.social/@le_futurologue' }
			]}
		/>
	</div>
</Section>

<footer
	style="background-color: var(--dark-800); color: rgba(255, 255, 255, 0.7); padding: var(--space-8); text-align: center; font-size: var(--text-sm);"
>
	<p>© 2025 Le Futurologue. Tous droits réservés.</p>
</footer>
