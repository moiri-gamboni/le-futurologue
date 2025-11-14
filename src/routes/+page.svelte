<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import * as Carousel from '$lib/components/ui/carousel';
	import * as Avatar from '$lib/components/ui/avatar';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Separator } from '$lib/components/ui/separator';
	import { Badge } from '$lib/components/ui/badge';
	import { ChevronDown } from 'lucide-svelte';
	import Section from '$lib/components/Section.svelte';
	import SectionHeading from '$lib/components/SectionHeading.svelte';
	import FormField from '$lib/components/FormField.svelte';
	import { enhance } from '$app/forms';

	let { form }: { form?: import('./$types').ActionData } = $props();

	// Images
	import heroImage from '$lib/assets/images/IMG_8029.jpeg?enhanced';
	import conferenceImage from '$lib/assets/images/IMG_8028.jpeg?enhanced';
	import profileImage from '$lib/assets/images/IMG_7197.jpeg';
	import logoVyv from '$lib/assets/logos/groupe-vyv.svg';
	import logoRec from '$lib/assets/logos/rec.webp';
	import logoAef from '$lib/assets/logos/aef.png';
	import logoEurekafe from '$lib/assets/logos/eurekafe.png';
	import logoTransvision from '$lib/assets/logos/transvision.png';

	// Data
	const stats = [
		{ id: 'videos', value: '180+', label: 'vidéos' },
		{ id: 'followers', value: '80K+', label: 'abonnés' },
		{ id: 'listens', value: '170K+', label: 'écoutes/mois' }
	];

	const logos = [
		{ id: 'vyv', src: logoVyv, alt: 'Groupe VYV' },
		{ id: 'transvision', src: logoTransvision, alt: 'TransVision' },
		{ id: 'esprit', src: logoRec, alt: 'Rencontres Esprit Critique' },
		{ id: 'ae', src: logoAef, alt: 'Altruisme Efficace France' },
		{ id: 'eurekafe', src: logoEurekafe, alt: 'Eurêkafé' }
	];

	const conferences = [
		{ id: 'yusjUh-2a7E', title: 'TransVision 2022' },
		{ id: 'xnBLgKEs9aM', title: 'Rencontres Esprit Critique' },
		{ id: 'sCRh9Pd8z_k', title: 'Altruisme Efficace France' }
	];

	const socials = [
		{ id: 'youtube', name: 'YouTube', url: 'https://youtube.com/@lefuturologuepodcast' },
		{ id: 'instagram', name: 'Instagram', url: 'https://instagram.com/le.futurologue' },
		{ id: 'linkedin', name: 'LinkedIn', url: 'https://linkedin.com/in/shaimanthurler' },
		{ id: 'twitter', name: 'Twitter/X', url: 'https://twitter.com/le_futurologue' },
		{ id: 'facebook', name: 'Facebook', url: 'https://facebook.com/le.futurologue' },
		{ id: 'tiktok', name: 'TikTok', url: 'https://tiktok.com/@le.futurologue' },
		{ id: 'threads', name: 'Threads', url: 'https://threads.net/@le.futurologue' },
		{ id: 'bluesky', name: 'Bluesky', url: 'https://bsky.app/profile/lefuturologue.bsky.social' },
		{ id: 'mastodon', name: 'Mastodon', url: 'https://mastodon.social/@le_futurologue' },
		{ id: 'discord', name: 'Discord', url: 'https://discord.gg/DqfKxvxYYg' }
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
		{ id: 'duration', label: 'Durée:', text: 'Adaptable de 15 min à 3h' },
		{ id: 'location', label: 'Lieu:', text: 'En présentiel (France & international) ou en visio' },
		{ id: 'format', label: 'Format:', text: 'Pédagogique, approfondi, constructif' }
	];
</script>

<svelte:head>
	<title>Shaïman Thürler - Conférencier spécialiste en IA | Le Futurologue</title>
	<meta
		name="description"
		content="Conférences sur l'intelligence artificielle, le futur du travail et les enjeux technologiques. Fondateur du plus grand podcast francophone sur l'IA."
	/>
</svelte:head>

<!-- Hero Section -->
<section class="relative flex min-h-screen items-center justify-center bg-dark-800">
	<enhanced:img
		src={heroImage}
		alt="Shaïman Thürler"
		class="absolute inset-0 h-full w-full object-cover"
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

		<div class="absolute bottom-8 left-1/2 -translate-x-1/2 animate-bounce">
			<ChevronDown class="h-8 w-8 text-white/50" />
		</div>
	</div>
</section>

<!-- Stats Bar -->
<Section theme="dark" padding="sm">
	<div class="grid grid-cols-1 gap-8 md:grid-cols-3">
		{#each stats as stat (stat.id)}
			<div class="text-center">
				<div class="mb-2 text-4xl font-bold text-green-500 md:text-5xl">{stat.value}</div>
				<div class="text-base text-white/70">{stat.label}</div>
			</div>
		{/each}
	</div>
</Section>

<!-- Client Logos Carousel -->
<Section theme="light" padding="sm">
	<Carousel.Root
		opts={{
			align: 'start',
			loop: true
		}}
		class="w-full"
	>
		<Carousel.Content class="-ml-4">
			{#each [...logos, ...logos] as logo, index (logo.id + '-' + index)}
				<Carousel.Item class="basis-1/2 pl-4 md:basis-1/3 lg:basis-1/4">
					<div
						class="flex h-20 items-center justify-center grayscale transition-all hover:grayscale-0"
					>
						<img src={logo.src} alt={logo.alt} class="max-h-16 object-contain" />
					</div>
				</Carousel.Item>
			{/each}
		</Carousel.Content>
		<Carousel.Previous class="hidden md:flex" />
		<Carousel.Next class="hidden md:flex" />
	</Carousel.Root>
</Section>

<!-- Value Proposition -->
<Section theme="light" width="xl" padding="md">
	<div class="grid gap-12 md:grid-cols-2 md:gap-16">
		<div class="order-2 md:order-1">
			<AspectRatio ratio={4 / 3}>
				<enhanced:img
					src={conferenceImage}
					alt="Conférence en action"
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
			<ul class="mb-8 space-y-3 text-lg">
				{#each detailsList as detail (detail.id)}
					<li class="flex items-start">
						<span class="mr-3 font-semibold text-foreground">{detail.label}</span>
						<span class="text-foreground/80">{detail.text}</span>
					</li>
				{/each}
			</ul>
			<div>
				<Button href="#contact" size="lg">Réserver une conférence</Button>
			</div>
		</div>
	</div>
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
				Je suis le fondateur du média <strong class="font-semibold text-white"
					>Le Futurologue</strong
				>, le plus grand podcast francophone sur l'intelligence artificielle.
			</p>
			<p>
				À travers des interviews, des débats et des analyses, mon objectif est d'expliquer les
				enjeux de l'IA de façon simple et rigoureuse. J'ai eu le privilège d'échanger avec des
				dizaines d'experts de premier plan et de donner de nombreuses conférences et interventions
				publiques.
			</p>
		</div>

		<Button variant="secondary" href="https://youtube.com/@lefuturologuepodcast" size="lg">
			Voir ma chaîne YouTube &rarr;
		</Button>
	</div>
</Section>

<!-- Conference Topics -->
<Section theme="light" width="md" padding="md">
	<SectionHeading>Thèmes de conférences</SectionHeading>

	<Card.Root class="mb-8 border-green-500/20 bg-green-500/5">
		<Card.Header>
			<div class="mb-2 flex items-center gap-2">
				<Badge class="bg-green-500 text-dark-800">Conférence principale</Badge>
			</div>
			<Card.Title class="text-xl md:text-2xl">
				Le futur et les dangers de l'intelligence artificielle
			</Card.Title>
		</Card.Header>
		<Card.Content>
			<p class="text-foreground/80">
				Un panorama clair et accessible de la trajectoire dans laquelle nous sommes embarqués.
				Point de départ idéal pour comprendre les vrais enjeux derrière le battage médiatique.
			</p>
		</Card.Content>
	</Card.Root>

	<div>
		<h3 class="mb-6 text-xl font-semibold text-foreground">Autres interventions possibles</h3>
		<ul class="grid gap-3 md:grid-cols-2">
			{#each topics as topic (topic.id)}
				<li class="flex items-start">
					<span class="mr-3 mt-1 h-1.5 w-1.5 flex-shrink-0 rounded-full bg-green-500"></span>
					<span class="text-foreground/80">{topic.text}</span>
				</li>
			{/each}
		</ul>
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
									alt={video.title}
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
						<p class="text-sm text-white/90">{video.title}</p>
					</Card.Footer>
				</Card.Root>
			{/each}
		</div>
	</div>

	<div class="text-center">
		<Button
			variant="outline"
			href="https://youtube.com/playlist?list=PLNMPbCcPxm0ed03TEQ2_Cy0cUsnIUd_nZ"
			class="border-white/20 text-white hover:bg-white/10"
		>
			Voir toutes les interviews données &rarr;
		</Button>
	</div>
</Section>

<!-- Contact Section -->
<Section id="contact" theme="light" width="sm" padding="md">
	<SectionHeading>Me contacter</SectionHeading>

	{#if form?.success}
		<div class="mb-8 rounded-lg border border-green-500/20 bg-green-500/10 p-4 text-center">
			<p class="text-green-700 dark:text-green-300">{form.message}</p>
		</div>
	{/if}

	{#if form?.error}
		<div class="mb-8 rounded-lg border border-red-500/20 bg-red-500/10 p-4 text-center">
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
			required
		/>
		<FormField
			id="email"
			name="email"
			type="email"
			label="Email"
			placeholder="votre@email.com"
			value={form?.email ?? ''}
			required
		/>
		<FormField
			id="organization"
			name="organization"
			label="Organisation"
			placeholder="Votre entreprise ou organisation"
			value={form?.organization ?? ''}
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
				>
					{social.name}
				</Button>
			{/each}
		</div>
	</div>
</Section>

<!-- Footer -->
<Separator />
<footer class="bg-background py-8 text-center">
	<p class="text-sm text-foreground/60">© 2025 Le Futurologue. Tous droits réservés.</p>
</footer>
