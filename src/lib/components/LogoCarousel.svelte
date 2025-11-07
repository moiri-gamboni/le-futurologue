<script lang="ts">
	interface Logo {
		src: string;
		alt: string;
	}

	interface Props {
		logos: Logo[];
	}

	let { logos }: Props = $props();

	// Duplicate logos for infinite scroll effect
	const duplicatedLogos = [...logos, ...logos];
</script>

<section class="logo-carousel">
	<div class="track">
		{#each duplicatedLogos as logo}
			<div class="logo-item">
				<img src={logo.src} alt={logo.alt} loading="lazy" />
			</div>
		{/each}
	</div>
</section>

<style>
	.logo-carousel {
		width: 100%;
		background-color: var(--light);
		padding: var(--space-12) 0;
		overflow: hidden;
	}

	.track {
		display: flex;
		gap: var(--space-12);
		animation: scroll 20s linear infinite;
		width: fit-content;
	}

	.track:hover {
		animation-play-state: paused;
	}

	@keyframes scroll {
		from {
			transform: translateX(0);
		}
		to {
			transform: translateX(-50%);
		}
	}

	@media (prefers-reduced-motion: reduce) {
		.track {
			animation: none;
		}
	}

	.logo-item {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-shrink: 0;
	}

	.logo-item img {
		max-height: 60px;
		width: auto;
		filter: grayscale(100%);
		opacity: 0.7;
		transition: all var(--transition-base);
		loading: lazy;
	}

	.logo-item img:hover {
		filter: grayscale(0%);
		opacity: 1;
	}
</style>
