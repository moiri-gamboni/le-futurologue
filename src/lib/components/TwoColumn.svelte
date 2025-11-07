<script lang="ts">
	interface Props {
		image?: string;
		imagePosition?: 'left' | 'right';
		imageAlt?: string;
		children?: import('svelte').Snippet;
	}

	let { image, imagePosition = 'left', imageAlt = '', children }: Props = $props();
</script>

<div class="two-column" class:image-left={imagePosition === 'left'} class:image-right={imagePosition === 'right'}>
	{#if image}
		<div class="image-column">
			<img src={image} alt={imageAlt} loading="lazy" />
		</div>
	{/if}
	<div class="content-column">
		{@render children?.()}
	</div>
</div>

<style>
	.two-column {
		display: grid;
		grid-template-columns: 1fr;
		gap: var(--space-8);
		align-items: center;
		width: 100%;
	}

	@media (min-width: 768px) {
		.two-column {
			grid-template-columns: 40% 1fr;
			gap: var(--space-12);
		}

		.two-column.image-right {
			grid-template-columns: 1fr 40%;
		}
	}

	.image-column {
		width: 100%;
		overflow: hidden;
		border-radius: var(--radius-md);
	}

	.image-column img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		display: block;
	}

	.content-column {
		width: 100%;
	}

	/* On mobile, image always comes first */
	@media (max-width: 767px) {
		.two-column {
			grid-template-columns: 1fr;
		}

		.image-column {
			order: -1;
		}
	}

	/* Desktop: image-right puts content first in grid */
	@media (min-width: 768px) {
		.two-column.image-right .content-column {
			order: -1;
		}
	}

	/* Typography adjustments within content column */
	.content-column :global(h2) {
		margin-bottom: var(--space-6);
	}

	.content-column :global(h3) {
		margin-bottom: var(--space-4);
	}

	.content-column :global(p) {
		margin-bottom: var(--space-6);
	}

	.content-column :global(ul) {
		margin-bottom: var(--space-8);
	}
</style>
