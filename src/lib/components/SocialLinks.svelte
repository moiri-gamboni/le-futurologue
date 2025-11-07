<script lang="ts">
	interface Platform {
		name: string;
		url: string;
		icon?: string;
	}

	interface Props {
		platforms: Platform[];
	}

	let { platforms }: Props = $props();

	// Simple icon mapping - using text for now, could be replaced with actual icon library
	const icons: Record<string, string> = {
		YouTube: '▶',
		Instagram: '📷',
		LinkedIn: '💼',
		'Twitter/X': '𝕏',
		Facebook: 'f',
		TikTok: '🎵',
		Bluesky: '☁️',
		Mastodon: '🦣',
		Threads: '@',
		Discord: '💬'
	};

	function getIcon(name: string): string {
		return icons[name] || '🔗';
	}
</script>

<div class="social-links">
	{#each platforms as platform}
		<a
			href={platform.url}
			class="social-link"
			target="_blank"
			rel="noopener noreferrer"
			aria-label={platform.name}
		>
			<span class="icon" aria-hidden="true">{getIcon(platform.name)}</span>
			<span class="label">{platform.name}</span>
		</a>
	{/each}
</div>

<style>
	.social-links {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
		gap: var(--space-4);
		width: 100%;
		max-width: 800px;
		margin: var(--space-8) auto 0;
	}

	@media (max-width: 640px) {
		.social-links {
			grid-template-columns: repeat(2, 1fr);
		}
	}

	.social-link {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: var(--space-4);
		background-color: transparent;
		border: 2px solid var(--grey-300);
		border-radius: var(--radius-md);
		text-decoration: none;
		color: inherit;
		transition: all var(--transition-base);
		min-height: 80px;
	}

	.social-link:hover {
		border-color: var(--green-500);
		background-color: rgba(74, 218, 86, 0.05);
		transform: translateY(-2px);
		box-shadow: var(--shadow-sm);
	}

	.social-link:focus-visible {
		outline: 2px solid var(--green-500);
		outline-offset: 2px;
	}

	.icon {
		font-size: var(--text-2xl);
		margin-bottom: var(--space-2);
		display: block;
	}

	.label {
		font-size: var(--text-sm);
		font-weight: var(--weight-semibold);
		text-align: center;
	}

	@media (prefers-reduced-motion: reduce) {
		.social-link {
			transition: none;
		}

		.social-link:hover {
			transform: none;
		}
	}
</style>
