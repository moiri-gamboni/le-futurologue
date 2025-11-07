/**
 * Svelte action for fade-in animations on scroll
 * Uses Intersection Observer API
 */

interface FadeInOptions {
	delay?: number;
	duration?: number;
	threshold?: number;
	once?: boolean;
}

export function fadeIn(node: HTMLElement, options: FadeInOptions = {}) {
	const { delay = 0, duration = 600, threshold = 0.1, once = true } = options;

	// Check for reduced motion preference
	const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

	if (prefersReducedMotion) {
		// Skip animation if user prefers reduced motion
		return {};
	}

	// Set initial state
	node.style.opacity = '0';
	node.style.transform = 'translateY(20px)';
	node.style.transition = `opacity ${duration}ms ease-out, transform ${duration}ms ease-out`;
	node.style.transitionDelay = `${delay}ms`;

	const observer = new IntersectionObserver(
		(entries) => {
			entries.forEach((entry) => {
				if (entry.isIntersecting) {
					// Trigger animation
					node.style.opacity = '1';
					node.style.transform = 'translateY(0)';

					// Disconnect after first trigger if once is true
					if (once) {
						observer.disconnect();
					}
				} else if (!once) {
					// Reset animation if once is false
					node.style.opacity = '0';
					node.style.transform = 'translateY(20px)';
				}
			});
		},
		{
			threshold,
			rootMargin: '0px 0px -50px 0px' // Trigger slightly before element enters viewport
		}
	);

	observer.observe(node);

	return {
		destroy() {
			observer.disconnect();
		}
	};
}
