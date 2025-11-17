<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import * as Carousel from '$lib/components/ui/carousel';
	import * as Avatar from '$lib/components/ui/avatar';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Separator } from '$lib/components/ui/separator';
	import Icon from '@iconify/svelte';
	import Section from '$lib/components/Section.svelte';
	import SectionHeading from '$lib/components/SectionHeading.svelte';
	import FormField from '$lib/components/FormField.svelte';
	import { enhance } from '$app/forms';
	import Autoplay from 'embla-carousel-autoplay';
	import { browser } from '$app/environment';

	let { form }: { form?: import('./$types').ActionData } = $props();

	// Detect prefers-reduced-motion
	let prefersReducedMotion = $state(false);
	if (browser) {
		prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
	}

	// Images
	import heroImage from '$lib/assets/images/hero.jpeg?enhanced';
	import conferenceImage from '$lib/assets/images/IMG_8028.jpeg?enhanced';
	import profileImage from '$lib/assets/images/IMG_7197.jpeg';
	import logoVyv from '$lib/assets/logos/groupe-vyv.svg';
	import logoRec from '$lib/assets/logos/rec.webp';
	import logoAef from '$lib/assets/logos/aef.png';
	import logoEurekafe from '$lib/assets/logos/eurekafe.png';
	import logoTransvision from '$lib/assets/logos/transvision.png';

	// Data
	const stats = [
		{ id: 'videos', value: '280+', label: 'vidéos' },
		{ id: 'followers', value: '80K+', label: 'abonnés' },
		{ id: 'views', value: '11M+', label: 'vues' }
	];

	const logos = [
		{ id: 'vyv', src: logoVyv, alt: 'Groupe VYV' },
		{ id: 'transvision', src: logoTransvision, alt: 'TransVision' },
		{ id: 'esprit', src: logoRec, alt: 'Rencontres Esprit Critique' },
		{ id: 'ae', src: logoAef, alt: 'Altruisme Efficace France' },
		{ id: 'eurekafe', src: logoEurekafe, alt: 'Eurêkafé' }
	];

	const conferences = [
		{ id: 'yusjUh-2a7E' },
		{ id: 'xnBLgKEs9aM' },
		{ id: 'sCRh9Pd8z_k' }
	];

	const interviewsGiven = [
		{
			id: 'Fks-t_3w1vw',
			description: 'Jennifer Prendki, docteure en physique des particules et ex directrice du département data de Google DeepMind.'
		},
		{
			id: '97H71XMy4EI',
			description: 'Axelle Arquié, docteure en économie, spécialiste du marché du travail et cofondatrice de l\'Observatoire des Emplois Menacés et Émergents.'
		},
		{
			id: '_wr55txHiYs',
			description: 'Charbel-Raphaël Segerie, ingénieur et chercheur en IA, expert IA auprès de l\'OCDE, directeur du Centre pour la Sécurité de l\'IA.'
		}
	];

	const interviewsTaken = [
		{ id: '3_af3JN898w' },
		{ id: '9cG0pJU10xs' },
		{ id: '2n8bJWO5_yY' }
	];

	const socials = [
		{ id: 'youtube', name: 'YouTube', url: 'https://youtube.com/@lefuturologuepodcast', icon: 'simple-icons:youtube' },
		{ id: 'instagram', name: 'Instagram', url: 'https://instagram.com/le.futurologue', icon: 'simple-icons:instagram' },
		{ id: 'linkedin', name: 'LinkedIn', url: 'https://linkedin.com/in/shaimanthurler', icon: 'simple-icons:linkedin' },
		{ id: 'twitter', name: 'Twitter/X', url: 'https://twitter.com/le_futurologue', icon: 'simple-icons:x' },
		{ id: 'facebook', name: 'Facebook', url: 'https://facebook.com/le.futurologue', icon: 'simple-icons:facebook' },
		{ id: 'tiktok', name: 'TikTok', url: 'https://tiktok.com/@le.futurologue', icon: 'simple-icons:tiktok' },
		{ id: 'threads', name: 'Threads', url: 'https://threads.net/@le.futurologue', icon: 'simple-icons:threads' },
		{ id: 'bluesky', name: 'Bluesky', url: 'https://bsky.app/profile/lefuturologue.bsky.social', icon: 'simple-icons:bluesky' },
		{ id: 'mastodon', name: 'Mastodon', url: 'https://mastodon.social/@le_futurologue', icon: 'simple-icons:mastodon' },
		{ id: 'discord', name: 'Discord', url: 'https://discord.gg/DqfKxvxYYg', icon: 'simple-icons:discord' }
	];

	const topics = [
		{ id: 'work', text: 'Le futur du travail' },
		{ id: 'geopolitics', text: 'Les enjeux géopolitiques de l\'IA' },
		{ id: 'sovereignty', text: 'La souveraineté numérique' },
		{ id: 'robotics', text: 'La robotique' },
		{ id: 'psychology', text: 'Les impacts psychologiques de l\'IA' },
		{ id: 'custom', text: 'Thèmes sur mesure selon vos besoins' }
	];

	const detailsList = [
		{ id: 'duration', icon: 'lucide:clock', text: 'Adaptable de 15 min à 3h' },
		{ id: 'location', icon: 'lucide:map-pin', text: 'En présentiel (France & international) ou en visio' },
		{ id: 'format', icon: 'lucide:presentation', text: 'Pédagogique, approfondi et constructif' }
	];
</script>

<svelte:head>
	<title>Shaïman Thürler - Conférencier spécialiste en IA | Le Futurologue</title>
	<meta
		name="description"
		content="Conférences sur l'intelligence artificielle, le futur du travail et les enjeux technologiques. Fondateur du plus grand podcast francophone sur l'IA."
	/>
</svelte:head>

<!-- Skip to main content link for keyboard users -->
<a
	href="#main-content"
	class="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:rounded focus:bg-green-500 focus:px-4 focus:py-2 focus:text-dark-800 focus:outline-none focus:ring-2 focus:ring-white"
>
	Aller au contenu principal
</a>

<!-- Hero Section -->
<header class="relative flex min-h-screen items-center justify-center bg-dark-800">
	<enhanced:img
		src={heroImage}
		alt="Portrait de Shaïman Thürler, conférencier spécialiste en intelligence artificielle"
		class="absolute inset-0 h-full w-full object-cover object-center"
		sizes="100vw"
	/>
	<div class="absolute inset-0 bg-dark-800/85"></div>

	<div class="relative z-10 mx-auto max-w-3xl px-8 text-center">
		<h1
			class="mb-6 text-5xl font-bold leading-tight tracking-tight text-white md:text-7xl md:tracking-tighter"
		>
			Shaïman Thürler
		</h1>
		<p class="mb-12 text-xl text-white/80 md:text-2xl">
			Conférencier spécialiste en intelligence artificielle
		</p>
		<Button href="#contact" size="lg" class="text-base font-semibold shadow-lg shadow-green-500/30">
			Me contacter &rarr;
		</Button>
	</div>

	<!-- Scroll indicator at bottom of hero section -->
	<div
		class="absolute bottom-8 left-1/2 z-10 -translate-x-1/2 motion-safe:animate-bounce"
		aria-hidden="true"
	>
		<Icon icon="lucide:chevron-down" class="h-8 w-8 text-white/50" />
	</div>
</header>

<main id="main-content">
	<!-- Stats Bar -->
	<Section theme="dark" padding="sm">
		<div class="grid grid-cols-1 gap-8 md:grid-cols-3">
			{#each stats as stat (stat.id)}
				<dl class="text-center">
					<dt class="sr-only">{stat.label}</dt>
					<dd class="mb-2 text-4xl font-bold text-green-500 md:text-5xl">{stat.value}</dd>
					<dt class="text-base text-white/70">{stat.label}</dt>
				</dl>
			{/each}
		</div>
	</Section>

<!-- Client Logos Carousel -->
<Section theme="light" padding="sm">
	<SectionHeading>Quelques conférences réalisées</SectionHeading>

	<Carousel.Root
		opts={{
			align: 'start',
			loop: true
		}}
		plugins={prefersReducedMotion
			? []
			: [
					Autoplay({
						delay: 2000,
						stopOnInteraction: false
					})
				]}
		class="w-full"
		aria-label="Logos des organisations où des conférences ont été données"
		aria-live={prefersReducedMotion ? 'off' : 'polite'}
	>
		<Carousel.Content class="-ml-4">
			{#each [...logos, ...logos] as logo, index (logo.id + '-' + index)}
				<Carousel.Item class="basis-1/2 pl-4 md:basis-1/3 lg:basis-1/4">
					<figure class="flex flex-col items-center justify-center gap-3">
						<div class="flex h-20 w-full items-center justify-center px-4">
							<img src={logo.src} alt={logo.alt} class="h-auto max-h-16 w-auto max-w-full object-contain" />
						</div>
						<figcaption class="text-center text-sm text-foreground/70">{logo.alt}</figcaption>
					</figure>
				</Carousel.Item>
			{/each}
		</Carousel.Content>
	</Carousel.Root>
</Section>

<!-- About Section -->
<Section theme="dark" width="md" padding="md">
	<div class="text-center">
		<div class="mb-8 flex justify-center">
			<Avatar.Root class="h-32 w-32 border-4 border-green-500/20 md:h-40 md:w-40">
				<Avatar.Image src={profileImage} alt="Shaïman Thürler" />
				<Avatar.Fallback class="bg-green-500 text-2xl font-bold text-dark-800">ST</Avatar.Fallback
				>
			</Avatar.Root>
		</div>

		<SectionHeading theme="dark">Qui suis-je ?</SectionHeading>

		<div class="mb-8 space-y-4 text-lg leading-relaxed text-white/90">
			<p>
				Fondateur du média Le Futurologue, j'anime aujourd'hui le plus grand podcast francophone dédié à l'intelligence artificielle.
			</p>
			<p>
				À travers des interviews avec des experts de premier plan, j'explore en profondeur les enjeux contemporains de l'IA afin de construire une vision globale et cohérente.
			</p>
			<p>
				Mon ambition est simple : proposer des analyses rigoureuses, accessibles et tournées vers l'avenir, pour mieux comprendre l'impact que l'intelligence artificielle aura sur nos sociétés.
			</p>
			<p>
				Que ce soit par le biais de mes vidéos, mes conférences ou mes interventions publiques, je m'attache à rendre ces enjeux compréhensibles et à fournir des clés de lecture essentielles pour les années à venir.
			</p>
		</div>

		<Button variant="secondary" href="https://youtube.com/@lefuturologuepodcast" size="lg">
			Voir ma chaîne YouTube &rarr;
		</Button>
	</div>
</Section>

<!-- Conferences Section -->
<Section theme="light" width="xl" padding="md">
	<!-- Main Conference -->
	<div class="grid gap-12 md:grid-cols-2 md:gap-16">
		<div class="order-2 md:order-1">
			<AspectRatio ratio={3 / 4}>
				<enhanced:img
					src={conferenceImage}
					alt="Shaïman Thürler donnant une conférence sur l'intelligence artificielle devant un auditoire"
					class="h-full w-full rounded-lg object-cover"
				/>
			</AspectRatio>
		</div>

		<div class="order-1 flex flex-col justify-center md:order-2">
			<h2 class="mb-6 text-3xl font-bold leading-tight text-foreground md:text-4xl">
				Ma conférence
			</h2>
			<p class="mb-6 text-lg leading-relaxed text-foreground/80">
				Ma conférence la plus demandée explore le futur et les dangers de l'intelligence
				artificielle. Elle offre un panorama clair et accessible de la trajectoire dans laquelle
				nous sommes embarqués.
			</p>
			<ul class="mb-8 space-y-4">
				{#each detailsList as detail (detail.id)}
					<li class="flex items-start gap-3">
						<Icon icon={detail.icon} class="mt-0.5 h-5 w-5 flex-shrink-0 text-green-500" aria-hidden="true" />
						<span class="text-base leading-relaxed text-foreground/80">{detail.text}</span>
					</li>
				{/each}
			</ul>
			<div class="mb-10">
				<Button href="#contact" size="lg">Réserver une conférence</Button>
			</div>

			<!-- Other Topics -->
			<div>
				<h3 class="mb-4 text-base font-medium text-foreground/70">
					Autres interventions possibles
				</h3>
				<ul class="grid gap-3 md:grid-cols-2 md:gap-x-4 md:gap-y-3">
					{#each topics as topic (topic.id)}
						<li class="flex items-start gap-2.5">
							<Icon icon="lucide:check" class="mt-0.5 h-4 w-4 flex-shrink-0 text-green-500" aria-hidden="true" />
							<span class="text-sm leading-relaxed text-foreground/80">{topic.text}</span>
						</li>
					{/each}
				</ul>
			</div>
		</div>
	</div>
</Section>

<!-- Media Section -->
<Section theme="dark" width="xl" padding="md">
	<SectionHeading theme="dark">Conférences & Interviews</SectionHeading>

	<div class="mb-12">
		<h3 class="mb-6 text-xl font-semibold text-white">Exemples de conférences réalisées</h3>
		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
			{#each conferences as video (video.id)}
				<Card.Root
					class="overflow-hidden border-white/10 bg-dark-700/50 transition-all hover:border-green-500/30 hover:shadow-lg hover:shadow-green-500/10"
				>
					<Card.Content class="p-0">
						<a
							href="https://youtube.com/watch?v={video.id}"
							target="_blank"
							rel="noopener noreferrer"
						>
							<AspectRatio ratio={16 / 9}>
								<img
									src="https://img.youtube.com/vi/{video.id}/maxresdefault.jpg"
									alt="Conférence réalisée"
									class="h-full w-full object-cover transition-transform hover:scale-105"
								/>
								<div
									class="absolute inset-0 flex items-center justify-center bg-dark-900/40 opacity-0 transition-opacity hover:opacity-100"
									aria-hidden="true"
								>
									<div
										class="flex h-16 w-16 items-center justify-center rounded-full bg-green-500/90"
									>
										<svg class="h-8 w-8 text-dark-800" fill="currentColor" viewBox="0 0 24 24">
											<path d="M8 5v14l11-7z" />
										</svg>
									</div>
								</div>
							</AspectRatio>
						</a>
					</Card.Content>
				</Card.Root>
			{/each}
		</div>
	</div>

	<div class="mb-12">
		<h3 class="mb-6 text-xl font-semibold text-white">Exemples d'interviews données</h3>
		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
			{#each interviewsGiven as interview (interview.id)}
				<Card.Root
					class="overflow-hidden border-white/10 bg-dark-700/50 transition-all hover:border-green-500/30 hover:shadow-lg hover:shadow-green-500/10"
				>
					<Card.Content class="p-0">
						<a
							href="https://youtube.com/watch?v={interview.id}"
							target="_blank"
							rel="noopener noreferrer"
						>
							<AspectRatio ratio={16 / 9}>
								<img
									src="https://img.youtube.com/vi/{interview.id}/maxresdefault.jpg"
									alt={interview.description}
									class="h-full w-full object-cover transition-transform hover:scale-105"
								/>
								<div
									class="absolute inset-0 flex items-center justify-center bg-dark-900/40 opacity-0 transition-opacity hover:opacity-100"
								>
									<div
										class="flex h-16 w-16 items-center justify-center rounded-full bg-green-500/90"
									>
										<svg class="h-8 w-8 text-dark-800" fill="currentColor" viewBox="0 0 24 24">
											<path d="M8 5v14l11-7z" />
										</svg>
									</div>
								</div>
							</AspectRatio>
						</a>
					</Card.Content>
					<Card.Footer class="p-4">
						<p class="text-sm text-white/90">{interview.description}</p>
					</Card.Footer>
				</Card.Root>
			{/each}
		</div>
	</div>

	<div>
		<h3 class="mb-6 text-xl font-semibold text-white">Exemples d'interviews réalisées</h3>
		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
			{#each interviewsTaken as interview (interview.id)}
				<Card.Root
					class="overflow-hidden border-white/10 bg-dark-700/50 transition-all hover:border-green-500/30 hover:shadow-lg hover:shadow-green-500/10"
				>
					<Card.Content class="p-0">
						<a
							href="https://youtube.com/watch?v={interview.id}"
							target="_blank"
							rel="noopener noreferrer"
						>
							<AspectRatio ratio={16 / 9}>
								<img
									src="https://img.youtube.com/vi/{interview.id}/maxresdefault.jpg"
									alt="Interview réalisée"
									class="h-full w-full object-cover transition-transform hover:scale-105"
								/>
								<div
									class="absolute inset-0 flex items-center justify-center bg-dark-900/40 opacity-0 transition-opacity hover:opacity-100"
								>
									<div
										class="flex h-16 w-16 items-center justify-center rounded-full bg-green-500/90"
									>
										<svg class="h-8 w-8 text-dark-800" fill="currentColor" viewBox="0 0 24 24">
											<path d="M8 5v14l11-7z" />
										</svg>
									</div>
								</div>
							</AspectRatio>
						</a>
					</Card.Content>
				</Card.Root>
			{/each}
		</div>
	</div>
</Section>

<!-- Contact Section -->
<Section id="contact" theme="light" width="sm" padding="md">
	<SectionHeading>Me contacter</SectionHeading>

	{#if form?.success}
		<div
			role="alert"
			aria-live="polite"
			class="mb-8 rounded-lg border border-green-500/20 bg-green-500/10 p-4 text-center"
		>
			<p class="text-green-700 dark:text-green-300">{form.message}</p>
		</div>
	{/if}

	{#if form?.error}
		<div
			role="alert"
			aria-live="assertive"
			class="mb-8 rounded-lg border border-red-500/20 bg-red-500/10 p-4 text-center"
		>
			<p class="text-red-700 dark:text-red-300">{form.error}</p>
		</div>
	{/if}

	<form method="POST" action="?/submit" use:enhance class="mb-12 space-y-6">
		<FormField
			id="name"
			name="name"
			label="Nom"
			placeholder="Votre nom complet"
			value={form?.name ?? ''}
			autocomplete="name"
			required
		/>
		<FormField
			id="email"
			name="email"
			type="email"
			label="Email"
			placeholder="votre@email.com"
			value={form?.email ?? ''}
			autocomplete="email"
			required
		/>
		<FormField
			id="organization"
			name="organization"
			label="Organisation"
			placeholder="Votre entreprise ou organisation"
			value={form?.organization ?? ''}
			autocomplete="organization"
		/>
		<FormField
			id="message"
			name="message"
			type="textarea"
			label="Message"
			placeholder="Parlez-moi de votre projet de conférence..."
			rows={5}
			value={form?.message ?? ''}
			required
		/>
		<Button type="submit" class="w-full" size="lg">Envoyer</Button>
	</form>

	<div class="mb-12 text-center">
		<p class="text-foreground/70">
			<strong class="font-semibold text-foreground">Email:</strong>
			<a href="mailto:contact@lefuturologue.com" class="ml-2 text-green-500 hover:underline">
				contact@lefuturologue.com
			</a>
		</p>
	</div>

	<div>
		<h3 class="mb-6 text-center text-xl font-semibold text-foreground">
			Retrouvez-moi sur les réseaux sociaux
		</h3>
		<div class="flex flex-wrap justify-center gap-3">
			{#each socials as social (social.id)}
				<Button
					variant="outline"
					size="sm"
					href={social.url}
					target="_blank"
					rel="noopener noreferrer"
					class="border-green-500/20 hover:border-green-500 hover:bg-green-500/10"
					aria-label="Visiter {social.name} (ouvre dans un nouvel onglet)"
				>
					<Icon icon={social.icon} class="mr-2 h-4 w-4" aria-hidden="true" />
					<span>{social.name}</span>
				</Button>
			{/each}
		</div>
	</div>
</Section>
</main>

<!-- Footer -->
<Separator />
<footer class="bg-background py-8 text-center">
	<p class="text-sm text-foreground/60">© 2025 Le Futurologue. Tous droits réservés.</p>
</footer>
