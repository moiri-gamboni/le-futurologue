<script lang="ts">
	import * as Card from '$lib/components/ui/card';

	interface Props {
		videoId: string;
		alt: string;
		description?: string;
	}

	let { videoId, alt, description }: Props = $props();
</script>

<Card.Root
	class="group overflow-hidden border-white/10 bg-dark-700/50 py-0 transition-all hover:border-green-500/30 hover:shadow-lg hover:shadow-green-500/10"
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
					src="https://img.youtube.com/vi/{videoId}/sddefault.jpg"
					{alt}
					class="block h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
				/>
				<div
					class="absolute inset-0 flex items-center justify-center bg-dark-900/40 opacity-0 transition-opacity duration-300 group-hover:opacity-100"
				>
					<div class="flex h-16 w-16 items-center justify-center rounded-full bg-green-500/90">
						<svg class="h-8 w-8 text-dark-800" fill="currentColor" viewBox="0 0 24 24">
							<path d="M8 5v14l11-7z" />
						</svg>
					</div>
				</div>
			</div>
		</Card.Content>
		{#if description}
			<Card.Footer class="px-6 py-4">
				<p class="text-sm leading-relaxed text-white/90">{description}</p>
			</Card.Footer>
		{/if}
	</a>
</Card.Root>
