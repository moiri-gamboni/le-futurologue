<script lang="ts">
	import * as Carousel from '$lib/components/ui/carousel';
	import Autoplay from 'embla-carousel-autoplay';
	import type { CarouselAPI } from '$lib/components/ui/carousel/context';

	interface Logo {
		id: string;
		src: string;
		alt: string;
	}

	interface Props {
		logos: Logo[];
		prefersReducedMotion: boolean;
	}

	let { logos, prefersReducedMotion }: Props = $props();

	// Autoplay plugin instance
	const autoplay = Autoplay({
		delay: 3000,
		stopOnInteraction: false
	});

	// Reset autoplay timer on navigation
	let carouselApi = $state<CarouselAPI>();

	$effect(() => {
		if (!carouselApi) return;

		const onSelect = () => {
			autoplay.reset();
		};

		carouselApi.on('select', onSelect);

		return () => {
			carouselApi?.off('select', onSelect);
		};
	});
</script>

<div class="mx-auto max-w-[480px] md:max-w-[720px] lg:max-w-[960px]">
	<Carousel.Root
		opts={{
			align: 'start',
			loop: true
		}}
		plugins={prefersReducedMotion ? [] : [autoplay]}
		setApi={(api) => (carouselApi = api)}
		class="w-full"
		aria-label="Logos des organisations où des conférences ont été données"
		aria-live={prefersReducedMotion ? 'off' : 'polite'}
	>
		<Carousel.Content class="-ml-4">
			{#each [...logos, ...logos] as logo, index (logo.id + '-' + index)}
				<Carousel.Item class="basis-60 pl-4">
					<figure class="flex flex-col items-center justify-center gap-3">
						<div class="flex h-20 w-full items-center justify-center px-4">
							<img src={logo.src} alt={logo.alt} class="h-auto max-h-16 w-auto max-w-full object-contain" />
						</div>
						<figcaption class="text-center text-sm text-foreground/70">{logo.alt}</figcaption>
					</figure>
				</Carousel.Item>
			{/each}
		</Carousel.Content>
		<div class="mt-6 flex justify-center gap-4 md:hidden">
			<Carousel.Previous class="relative left-auto top-auto translate-y-0 border-green-500/30 bg-white hover:border-green-500 hover:bg-green-500/10" />
			<Carousel.Next class="relative right-auto top-auto translate-y-0 border-green-500/30 bg-white hover:border-green-500 hover:bg-green-500/10" />
		</div>
		<Carousel.Previous class="hidden border-green-500/30 bg-white hover:border-green-500 hover:bg-green-500/10 md:flex" />
		<Carousel.Next class="hidden border-green-500/30 bg-white hover:border-green-500 hover:bg-green-500/10 md:flex" />
	</Carousel.Root>
</div>
