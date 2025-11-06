<script lang="ts">
	interface Video {
		id: string;
		title: string;
		thumbnail?: string;
	}

	interface Props {
		videos: Video[];
	}

	let { videos }: Props = $props();

	function getThumbnail(video: Video): string {
		return video.thumbnail || `https://img.youtube.com/vi/${video.id}/maxresdefault.jpg`;
	}

	function getYouTubeUrl(id: string): string {
		return `https://www.youtube.com/watch?v=${id}`;
	}
</script>

<div class="media-grid">
	{#each videos as video}
		<a
			href={getYouTubeUrl(video.id)}
			class="media-card"
			style="background-image: url('{getThumbnail(video)}')"
			target="_blank"
			rel="noopener noreferrer"
			aria-label="Regarder {video.title} sur YouTube"
		>
			<div class="play-button">
				<svg
					width="64"
					height="64"
					viewBox="0 0 24 24"
					fill="white"
					xmlns="http://www.w3.org/2000/svg"
				>
					<path d="M8 5v14l11-7z" />
				</svg>
			</div>
		</a>
	{/each}
</div>

<style>
	.media-grid {
		display: grid;
		grid-template-columns: 1fr;
		gap: var(--space-4);
		width: 100%;
	}

	@media (min-width: 768px) {
		.media-grid {
			grid-template-columns: repeat(2, 1fr);
			gap: var(--space-6);
		}
	}

	@media (min-width: 1024px) {
		.media-grid {
			grid-template-columns: repeat(3, 1fr);
			gap: var(--space-8);
		}
	}

	.media-card {
		position: relative;
		aspect-ratio: 16 / 9;
		background-size: cover;
		background-position: center;
		background-repeat: no-repeat;
		border-radius: var(--radius-md);
		overflow: hidden;
		cursor: pointer;
		transition: transform var(--transition-slow);
		display: flex;
		align-items: center;
		justify-content: center;
		text-decoration: none;
	}

	.media-card::after {
		content: '';
		position: absolute;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		opacity: 0;
		transition: opacity var(--transition-slow);
	}

	.media-card:hover {
		transform: scale(1.05);
		box-shadow: var(--shadow-md);
	}

	.media-card:hover::after {
		opacity: 1;
	}

	.media-card:focus-visible {
		outline: 2px solid var(--green-500);
		outline-offset: 2px;
	}

	.play-button {
		position: relative;
		z-index: var(--z-base);
		width: 64px;
		height: 64px;
		background-color: rgba(0, 0, 0, 0.7);
		border-radius: var(--radius-full);
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all var(--transition-base);
	}

	.media-card:hover .play-button {
		background-color: var(--green-500);
		transform: scale(1.1);
	}

	@media (prefers-reduced-motion: reduce) {
		.media-card {
			transition: none;
		}

		.media-card:hover {
			transform: none;
		}
	}
</style>
