import tailwindcss from '@tailwindcss/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import { enhancedImages } from '@sveltejs/enhanced-img';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [tailwindcss(), enhancedImages(), sveltekit()],
	// Bind dev / preview to every interface (including tailscale0) so the
	// roost server's sessions are reachable from the laptop at
	// http://100.73.69.20:5173/. UFW allows traffic over tailscale0 by
	// default, so this doesn't open a port to the public internet.
	server: { host: true },
	preview: { host: true }
});
