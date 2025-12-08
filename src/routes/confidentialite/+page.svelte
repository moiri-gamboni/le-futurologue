<script lang="ts">
	import Section from '$lib/components/Section.svelte';
	import SectionHeading from '$lib/components/SectionHeading.svelte';
</script>

<svelte:head>
	<title>Politique de confidentialité - Le Futurologue</title>
	<meta
		name="description"
		content="Politique de confidentialité du site Le Futurologue. Nous respectons votre vie privée."
	/>
</svelte:head>

<Section theme="dark" width="md" padding="lg">
	<SectionHeading level="h1" theme="dark">Politique de confidentialité</SectionHeading>

	<div class="prose prose-invert mx-auto mt-8 max-w-none">
		<p class="text-lg text-grey-300">
			Votre vie privée est importante. Cette page explique comment nous traitons vos données
			lorsque vous visitez ce site.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-grey-100">Données collectées</h2>
		<p class="mt-4 text-grey-300">
			Ce site ne collecte <strong class="text-grey-100">aucune donnée personnelle identifiable</strong
			>. Nous n'utilisons pas de cookies, nous ne suivons pas votre navigation entre les sites, et
			nous ne partageons aucune information avec des tiers.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-grey-100">Analyse d'audience</h2>
		<p class="mt-4 text-grey-300">
			Nous utilisons <a
				href="https://www.simpleanalytics.com"
				target="_blank"
				rel="noopener noreferrer"
				class="text-green-400 underline hover:text-green-300">Simple Analytics</a
			>, un service d'analyse respectueux de la vie privée. Simple Analytics :
		</p>
		<ul class="mt-4 list-inside list-disc space-y-2 text-grey-300">
			<li>Ne collecte pas d'adresses IP</li>
			<li>N'utilise pas de cookies</li>
			<li>Ne suit pas les visiteurs entre les sites</li>
			<li>Est conforme au RGPD sans consentement requis</li>
		</ul>
		<p class="mt-4 text-grey-300">
			Seules des données agrégées et anonymes sont collectées (nombre de visites, pages consultées,
			pays d'origine approximatif).
		</p>

		<h2 class="mt-8 text-xl font-semibold text-grey-100">Formulaire de contact</h2>
		<p class="mt-4 text-grey-300">
			Si vous utilisez le formulaire de contact, les informations que vous fournissez (nom, email,
			message) sont uniquement utilisées pour répondre à votre demande. Ces données ne sont pas
			stockées dans une base de données.
		</p>
		<p class="mt-4 text-grey-300">
			L'envoi des emails est assuré par <a
				href="https://resend.com"
				target="_blank"
				rel="noopener noreferrer"
				class="text-green-400 underline hover:text-green-300">Resend</a
			>, un service conforme au RGPD. Resend conserve les métadonnées des emails (adresses, objet,
			contenu) pour permettre le suivi de livraison. Ces données sont supprimées dans les 90 jours
			suivant la fermeture du compte. Voir leur
			<a
				href="https://resend.com/legal/privacy-policy"
				target="_blank"
				rel="noopener noreferrer"
				class="text-green-400 underline hover:text-green-300">politique de confidentialité</a
			>.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-grey-100">Vos droits</h2>
		<p class="mt-4 text-grey-300">
			Conformément au RGPD, vous disposez d'un droit d'accès, de rectification et de suppression de
			vos données. Étant donné que nous ne collectons pas de données personnelles identifiables, ces
			droits s'appliquent uniquement aux éventuels échanges par email suite à une prise de contact.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-grey-100">Contact</h2>
		<p class="mt-4 text-grey-300">
			Pour toute question concernant cette politique de confidentialité, vous pouvez me contacter
			via le <a href="/#contact" class="text-green-400 underline hover:text-green-300"
				>formulaire de contact</a
			>.
		</p>

		<p class="mt-12 text-sm text-grey-500">Dernière mise à jour : décembre 2024</p>
	</div>

	<div class="mt-12 text-center">
		<a
			href="/"
			class="inline-flex items-center gap-2 text-green-400 transition-colors hover:text-green-300"
		>
			← Retour à l'accueil
		</a>
	</div>
</Section>
