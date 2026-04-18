<script lang="ts">
	import * as Card from '$lib/components/ui/card';

	interface Props {
		videoId: string;
		alt: string;
		description?: string;
	}

	let { videoId, alt, description }: Props = $props();

	// YouTube only generates `maxresdefault.jpg` (1280x720 16:9) when the
	// upload was >=720p. Older videos return 404 there — fall back to
	// `hqdefault.jpg` (480x360, 4:3 letterboxed) which is always available.
	let maxresFailed = $state(false);
	const thumbUrl = $derived(
		maxresFailed
			? `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`
			: `https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`
	);
</script>

<Card.Root
	class="group overflow-hidden border border-warm-100/15 bg-red-700/40 py-0 shadow-md transition-all hover:border-warm-100/40 hover:bg-red-700/55 hover:shadow-lg hover:shadow-red-500/10"
>
	<a
		href="https://youtube.com/watch?v={videoId}"
		target="_blank"
		rel="noopener noreferrer"
		class="block"
	>
		<Card.Content class="p-0">
			<div class="relative aspect-video overflow-hidden">
				<img
					src={thumbUrl}
					{alt}
					onerror={() => (maxresFailed = true)}
					class="block h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
				/>
				<div
					class="absolute inset-0 flex items-center justify-center bg-red-900/50 opacity-0 transition-opacity duration-300 group-hover:opacity-100"
				>
					<div class="flex h-16 w-16 items-center justify-center rounded-full bg-red-500/90">
						<svg class="h-8 w-8 text-warm-100" fill="currentColor" viewBox="0 0 24 24">
							<path d="M8 5v14l11-7z" />
						</svg>
					</div>
				</div>
			</div>
		</Card.Content>
		{#if description}
			<Card.Footer class="px-6 py-4">
				<p class="text-sm leading-relaxed text-warm-100/90">{description}</p>
			</Card.Footer>
		{/if}
	</a>
</Card.Root>
