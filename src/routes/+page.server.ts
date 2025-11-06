import type { Actions } from './$types';

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const name = data.get('name');
		const email = data.get('email');
		const organization = data.get('organization');
		const message = data.get('message');

		// TODO: Integrate with email service (SendGrid, Resend, etc.)
		// For now, just log to console
		console.log('Form submission:', { name, email, organization, message });

		// Return success
		return { success: true };
	}
} satisfies Actions;
