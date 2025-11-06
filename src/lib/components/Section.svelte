<script lang="ts">
	interface Props {
		theme?: 'light' | 'dark';
		width?: 'lg' | 'xl';
		children?: import('svelte').Snippet;
	}

	let { theme = 'light', width = 'lg', children }: Props = $props();
</script>

<section class="section" class:light={theme === 'light'} class:dark={theme === 'dark'}>
	<div class="container" class:container-lg={width === 'lg'} class:container-xl={width === 'xl'}>
		{@render children?.()}
	</div>
</section>

<style>
	.section {
		width: 100%;
		padding: var(--space-12) var(--space-6);
	}

	@media (min-width: 768px) {
		.section {
			padding: var(--space-16) var(--space-8);
		}
	}

	@media (min-width: 1200px) {
		.section {
			padding: var(--space-20) var(--space-8);
		}
	}

	.section.light {
		background-color: var(--light);
		color: var(--dark-600);
	}

	.section.dark {
		background-color: var(--dark-800);
		color: rgba(255, 255, 255, 0.95);
	}

	.container {
		width: 100%;
		margin-left: auto;
		margin-right: auto;
	}
</style>
