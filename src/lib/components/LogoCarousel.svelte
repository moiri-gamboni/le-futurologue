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
							<img
								src={logo.src}
								alt={logo.alt}
								class="h-auto max-h-16 w-auto max-w-full object-contain"
							/>
						</div>
						<figcaption class="text-center text-sm text-foreground/70">{logo.alt}</figcaption>
					</figure>
				</Carousel.Item>
			{/each}
		</Carousel.Content>
		<div class="mt-6 flex justify-center gap-6 xl:hidden">
			<Carousel.Previous
				variant="ghost"
				class="relative top-auto left-auto size-10 translate-y-0 rounded-none border-0 bg-transparent text-foreground shadow-none transition-colors hover:bg-transparent hover:text-primary [&_svg]:size-6"
			/>
			<Carousel.Next
				variant="ghost"
				class="relative top-auto right-auto size-10 translate-y-0 rounded-none border-0 bg-transparent text-foreground shadow-none transition-colors hover:bg-transparent hover:text-primary [&_svg]:size-6"
			/>
		</div>
		<Carousel.Previous
			variant="ghost"
			class="hidden size-10 rounded-none border-0 bg-transparent text-foreground shadow-none transition-colors hover:bg-transparent hover:text-primary xl:flex [&_svg]:size-6"
		/>
		<Carousel.Next
			variant="ghost"
			class="hidden size-10 rounded-none border-0 bg-transparent text-foreground shadow-none transition-colors hover:bg-transparent hover:text-primary xl:flex [&_svg]:size-6"
		/>
	</Carousel.Root>
</div>
