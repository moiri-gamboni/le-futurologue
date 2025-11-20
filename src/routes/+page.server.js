import { fail } from '@sveltejs/kit';
import { Resend } from 'resend';
import { RESEND_API_KEY } from '$env/static/private';

const resend = new Resend(RESEND_API_KEY);

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
				console.error('Resend API error:', error);
				return fail(500, {
					error: 'Une erreur est survenue lors de l\'envoi du message. Veuillez réessayer ou nous contacter directement par email.',
					name: name.toString(),
					email: email.toString(),
					organization: organization?.toString() || '',
					message: message.toString()
				});
			}

			console.log('Email sent successfully:', emailData);
			return {
				success: true,
				message: 'Votre message a été envoyé avec succès. Nous vous répondrons dans les plus brefs délais.'
			};
		} catch (error) {
			console.error('Error sending email:', error);
			return fail(500, {
				error: 'Une erreur est survenue lors de l\'envoi du message. Veuillez réessayer ou nous contacter directement par email.',
				name: name.toString(),
				email: email.toString(),
				organization: organization?.toString() || '',
				message: message.toString()
			});
		}
	}
};
