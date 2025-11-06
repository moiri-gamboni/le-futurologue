<script lang="ts">
	interface Props {
		variant?: 'primary' | 'secondary';
		href?: string;
		fullWidth?: boolean;
		type?: 'button' | 'submit' | 'reset';
		children?: import('svelte').Snippet;
	}

	let { variant = 'primary', href, fullWidth = false, type = 'button', children }: Props = $props();
</script>

{#if href}
	<a
		{href}
		class="button"
		class:primary={variant === 'primary'}
		class:secondary={variant === 'secondary'}
		class:full-width={fullWidth}
	>
		{@render children?.()}
	</a>
{:else}
	<button
		{type}
		class="button"
		class:primary={variant === 'primary'}
		class:secondary={variant === 'secondary'}
		class:full-width={fullWidth}
	>
		{@render children?.()}
	</button>
{/if}

<style>
	.button {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		padding: var(--space-4) var(--space-8);
		font-size: var(--text-base);
		font-weight: var(--weight-semibold);
		border-radius: var(--radius-md);
		text-decoration: none;
		transition: all var(--transition-base);
		cursor: pointer;
		min-height: 44px;
		border: none;
	}

	.button:focus-visible {
		outline: 2px solid var(--green-500);
		outline-offset: 2px;
	}

	/* Primary variant */
	.button.primary {
		background-color: var(--green-500);
		color: var(--dark-800);
		box-shadow: 0 4px 12px rgba(74, 218, 86, 0.3);
	}

	.button.primary:hover {
		background-color: var(--green-400);
		box-shadow: 0 6px 20px rgba(74, 218, 86, 0.4);
		transform: scale(1.02);
	}

	.button.primary:active {
		transform: scale(0.98);
		box-shadow: 0 2px 8px rgba(74, 218, 86, 0.3);
	}

	/* Secondary variant */
	.button.secondary {
		background-color: transparent;
		color: currentColor;
		border: 2px solid currentColor;
		box-shadow: none;
	}

	.button.secondary:hover {
		background-color: rgba(74, 218, 86, 0.1);
		transform: scale(1.02);
	}

	.button.secondary:active {
		transform: scale(0.98);
	}

	/* Full width option */
	.button.full-width {
		width: 100%;
	}

	/* Responsive sizing */
	@media (max-width: 768px) {
		.button {
			padding: var(--space-4) var(--space-6);
		}
	}
</style>
