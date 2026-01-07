import { fail } from '@sveltejs/kit';
import { Resend } from 'resend';
import { RESEND_API_KEY } from '$env/static/private';

const resend = new Resend(RESEND_API_KEY);

/**
 * Maps Resend API errors to user-friendly French messages
 * @param {{ name?: string, message?: string, statusCode?: number | null }} error
 * @returns {string}
 */
function getResendErrorMessage(error) {
	const errorName = error.name || '';
	const errorMessage = error.message || '';

	// Invalid reply-to email format
	if (errorName === 'validation_error' && errorMessage.toLowerCase().includes('reply_to')) {
		return 'L\'adresse email fournie n\'est pas valide. Veuillez vérifier le format (ex: exemple@email.com).';
	}

	// Other invalid email format errors
	if (errorName === 'validation_error' && errorMessage.toLowerCase().includes('email')) {
		return 'L\'adresse email fournie n\'est pas valide. Veuillez vérifier et réessayer.';
	}

	// Generic validation error
	if (errorName === 'validation_error') {
		return 'Les informations saisies contiennent une erreur. Veuillez vérifier et réessayer.';
	}

	// Rate limits and quotas (account-level, not user's fault)
	if (errorName === 'rate_limit_exceeded' || errorName === 'daily_quota_exceeded' || errorName === 'monthly_quota_exceeded') {
		return 'Le service de messagerie est temporairement surchargé. Veuillez réessayer dans quelques minutes ou nous contacter à contact@lefuturologue.com.';
	}

	// Server errors
	if (error.statusCode === 500 || errorName === 'application_error' || errorName === 'internal_server_error') {
		return 'Le service de messagerie rencontre un problème. Veuillez réessayer dans quelques instants ou nous contacter à contact@lefuturologue.com.';
	}

	// Security error
	if (errorName === 'security_error') {
		return 'Votre message n\'a pas pu être envoyé pour des raisons de sécurité. Veuillez nous contacter directement à contact@lefuturologue.com.';
	}

	// Default fallback
	return 'Une erreur est survenue lors de l\'envoi du message. Veuillez réessayer ou nous contacter à contact@lefuturologue.com.';
}

/** @type {import('./$types').Actions} */
export const actions = {
	submit: async ({ request }) => {
		const data = await request.formData();
		const name = data.get('name');
		const email = data.get('email');
		const organization = data.get('organization');
		const message = data.get('message');

		// Validation
		if (!name || typeof name !== 'string') {
			return fail(400, {
				error: 'Le nom est requis',
				name: name?.toString() || '',
				email: email?.toString() || '',
				organization: organization?.toString() || '',
				message: message?.toString() || ''
			});
		}

		if (!email || typeof email !== 'string' || !email.includes('@')) {
			return fail(400, {
				error: 'Une adresse email valide est requise',
				name: name.toString(),
				email: email?.toString() || '',
				organization: organization?.toString() || '',
				message: message?.toString() || ''
			});
		}

		if (!message || typeof message !== 'string' || message.trim().length < 10) {
			return fail(400, {
				error: 'Le message doit contenir au moins 10 caractères',
				name: name.toString(),
				email: email.toString(),
				organization: organization?.toString() || '',
				message: message?.toString() || ''
			});
		}

		try {
			// Send email via Resend
			const { data: emailData, error } = await resend.emails.send({
				from: 'Le Futurologue <contact@lefuturologue.com>',
				to: ['contact@lefuturologue.com'],
				replyTo: email.toString(),
				subject: `Formulaire de contact : ${name.toString()}${organization ? ` (${organization.toString()})` : ''}`,
				html: `
					<p><strong>Nom:</strong> ${name.toString()}</p>
					<p><strong>Email:</strong> ${email.toString()}</p>
					${organization ? `<p><strong>Organisation:</strong> ${organization.toString()}</p>` : ''}
					<hr />
					<p><strong>Message:</strong></p>
					<p>${message.toString().replace(/\n/g, '<br>')}</p>
				`
			});

			// Check if Resend API returned an error
			if (error) {
				console.error(JSON.stringify({
					event: 'contact_form_error',
					source: 'resend_api',
					error: {
						name: error.name,
						message: error.message,
						statusCode: error.statusCode
					}
				}));
				const userMessage = getResendErrorMessage(error);
				return fail(error.statusCode || 500, {
					error: userMessage,
					name: name.toString(),
					email: email.toString(),
					organization: organization?.toString() || '',
					message: message.toString()
				});
			}

			console.log(JSON.stringify({
				event: 'contact_form_success',
				emailId: emailData?.id
			}));
			return {
				success: true,
				successMessage: 'Votre message a été envoyé avec succès. Nous vous répondrons dans les plus brefs délais.'
			};
		} catch (error) {
			console.error(JSON.stringify({
				event: 'contact_form_error',
				source: 'unexpected',
				error: {
					message: error instanceof Error ? error.message : 'Unknown error',
					stack: error instanceof Error ? error.stack : undefined
				}
			}));
			return fail(500, {
				error: 'Une erreur inattendue est survenue. Veuillez réessayer ou nous contacter à contact@lefuturologue.com.',
				name: name.toString(),
				email: email.toString(),
				organization: organization?.toString() || '',
				message: message.toString()
			});
		}
	}
};
