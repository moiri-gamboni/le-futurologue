<script lang="ts">
	interface Props {
		background: string;
		children?: import('svelte').Snippet;
	}

	let { background, children }: Props = $props();
</script>

<section class="hero" style="background-image: url('{background}')">
	<div class="overlay"></div>
	<div class="content">
		{@render children?.()}
	</div>
	<div class="scroll-indicator">
		<svg
			width="24"
			height="24"
			viewBox="0 0 24 24"
			fill="none"
			stroke="currentColor"
			stroke-width="2"
			stroke-linecap="round"
			stroke-linejoin="round"
		>
			<polyline points="6 9 12 15 18 9"></polyline>
		</svg>
	</div>
</section>

<style>
	.hero {
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		width: 100%;
		background-size: cover;
		background-position: center;
		background-repeat: no-repeat;
	}

	.overlay {
		position: absolute;
		inset: 0;
		background-color: rgba(10, 10, 10, 0.85);
		z-index: var(--z-base);
	}

	.content {
		position: relative;
		z-index: calc(var(--z-base) + 1);
		text-align: center;
		color: white;
		max-width: var(--container-md);
		padding: var(--space-8);
	}

	.content :global(h1) {
		font-size: var(--text-3xl);
		font-weight: var(--weight-bold);
		letter-spacing: -0.02em;
		margin-bottom: var(--space-4);
		color: white;
	}

	.content :global(h2) {
		font-size: var(--text-xl);
		font-weight: var(--weight-regular);
		color: rgba(255, 255, 255, 0.8);
		margin-bottom: var(--space-8);
	}

	@media (min-width: 768px) {
		.content :global(h1) {
			font-size: var(--text-5xl);
		}

		.content :global(h2) {
			font-size: var(--text-xl);
		}
	}

	.scroll-indicator {
		position: absolute;
		bottom: var(--space-8);
		left: 50%;
		transform: translateX(-50%);
		color: white;
		opacity: 0.7;
		animation: bounce 2s infinite;
		z-index: calc(var(--z-base) + 1);
	}

	@keyframes bounce {
		0%,
		100% {
			transform: translateX(-50%) translateY(0);
		}
		50% {
			transform: translateX(-50%) translateY(10px);
		}
	}

	@media (prefers-reduced-motion: reduce) {
		.scroll-indicator {
			animation: none;
		}
	}
</style>
