<script lang="ts">
	interface Stat {
		value: string;
		label: string;
	}

	interface Props {
		stats: Stat[];
	}

	let { stats }: Props = $props();
</script>

<section class="stats-bar">
	<div class="stats-container">
		{#each stats as stat}
			<div class="stat">
				<div class="value">{stat.value}</div>
				<div class="label">{stat.label}</div>
			</div>
		{/each}
	</div>
</section>

<style>
	.stats-bar {
		width: 100%;
		background-color: var(--dark-800);
		padding: var(--space-12) var(--space-6);
	}

	.stats-container {
		display: grid;
		grid-template-columns: 1fr;
		gap: var(--space-8);
		max-width: var(--container-xl);
		margin: 0 auto;
		text-align: center;
	}

	@media (min-width: 640px) {
		.stats-container {
			grid-template-columns: repeat(2, 1fr);
		}
	}

	@media (min-width: 768px) {
		.stats-container {
			grid-template-columns: repeat(3, 1fr);
			gap: var(--space-12);
		}
	}

	.stat {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: var(--space-2);
	}

	.value {
		font-size: var(--text-3xl);
		font-weight: var(--weight-bold);
		color: var(--green-500);
		line-height: var(--leading-tight);
	}

	@media (min-width: 768px) {
		.value {
			font-size: var(--text-4xl);
		}
	}

	.label {
		font-size: var(--text-base);
		font-weight: var(--weight-regular);
		color: rgba(255, 255, 255, 0.7);
		line-height: var(--leading-normal);
	}
</style>
