<script lang="ts">
	let formState = $state<'idle' | 'submitting' | 'success' | 'error'>('idle');
	let errorMessage = $state('');

	async function handleSubmit(event: Event) {
		event.preventDefault();
		formState = 'submitting';

		const form = event.target as HTMLFormElement;
		const formData = new FormData(form);

		try {
			const response = await fetch(form.action, {
				method: 'POST',
				body: formData
			});

			if (response.ok) {
				formState = 'success';
				form.reset();
			} else {
				formState = 'error';
				errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
			}
		} catch (error) {
			formState = 'error';
			errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
		}
	}
</script>

<form class="contact-form" method="POST" onsubmit={handleSubmit}>
	<div class="form-group">
		<label for="name">Nom</label>
		<input type="text" id="name" name="name" required />
	</div>

	<div class="form-group">
		<label for="email">Email</label>
		<input type="email" id="email" name="email" required />
	</div>

	<div class="form-group">
		<label for="organization">Organisation</label>
		<input type="text" id="organization" name="organization" />
	</div>

	<div class="form-group">
		<label for="message">Message</label>
		<textarea id="message" name="message" rows="5" required></textarea>
	</div>

	{#if formState === 'success'}
		<div class="message success">Message envoyé avec succès !</div>
	{/if}

	{#if formState === 'error'}
		<div class="message error">{errorMessage}</div>
	{/if}

	<button type="submit" class="submit-button" disabled={formState === 'submitting'}>
		{formState === 'submitting' ? 'Envoi en cours...' : 'Envoyer'}
	</button>
</form>

<style>
	.contact-form {
		max-width: var(--container-sm);
		margin: 0 auto;
		width: 100%;
	}

	.form-group {
		margin-bottom: var(--space-6);
	}

	label {
		display: block;
		font-size: var(--text-sm);
		font-weight: var(--weight-semibold);
		margin-bottom: var(--space-2);
		color: var(--dark-600);
	}

	input,
	textarea {
		width: 100%;
		font-size: var(--text-base);
		padding: var(--space-4);
		background: transparent;
		border: none;
		border-bottom: 2px solid var(--grey-300);
		color: inherit;
		transition: border-color var(--transition-base);
		font-family: inherit;
	}

	input:focus,
	textarea:focus {
		outline: none;
		border-bottom-color: var(--green-500);
		box-shadow: 0 2px 0 0 var(--green-500);
	}

	textarea {
		resize: vertical;
		min-height: 120px;
	}

	.submit-button {
		width: 100%;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		padding: var(--space-4) var(--space-8);
		font-size: var(--text-base);
		font-weight: var(--weight-semibold);
		border-radius: var(--radius-md);
		background-color: var(--green-500);
		color: var(--dark-800);
		border: none;
		cursor: pointer;
		min-height: 44px;
		transition: all var(--transition-base);
		box-shadow: 0 4px 12px rgba(74, 218, 86, 0.3);
	}

	.submit-button:hover:not(:disabled) {
		background-color: var(--green-400);
		box-shadow: 0 6px 20px rgba(74, 218, 86, 0.4);
		transform: scale(1.02);
	}

	.submit-button:active:not(:disabled) {
		transform: scale(0.98);
	}

	.submit-button:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.message {
		padding: var(--space-4);
		border-radius: var(--radius-md);
		margin-bottom: var(--space-6);
		text-align: center;
	}

	.message.success {
		background-color: rgba(74, 218, 86, 0.1);
		color: var(--green-700);
		border: 1px solid var(--green-500);
	}

	.message.error {
		background-color: rgba(239, 68, 68, 0.1);
		color: #b91c1c;
		border: 1px solid #ef4444;
	}
</style>
