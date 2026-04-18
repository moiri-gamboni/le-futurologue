<script lang="ts">
	import Section from '$lib/components/Section.svelte';
	import SectionHeading from '$lib/components/SectionHeading.svelte';
	import { resolve } from '$app/paths';
</script>

<svelte:head>
	<title>Politique de confidentialité - Le Futurologue</title>
	<meta
		name="description"
		content="Politique de confidentialité du site Le Futurologue. Nous respectons votre vie privée."
	/>
</svelte:head>

<Section theme="cream" width="md" padding="lg">
	<SectionHeading level="h1" theme="cream">Politique de confidentialité</SectionHeading>

	<div class="prose mx-auto mt-8 max-w-none">
		<p class="text-lg text-foreground/75">
			Votre vie privée est importante. Cette page explique comment nous traitons vos données lorsque
			vous visitez ce site.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-foreground">Données collectées</h2>
		<p class="mt-4 text-foreground/75">
			Ce site ne collecte <strong class="text-foreground"
				>aucune donnée personnelle identifiable</strong
			>. Nous n'utilisons pas de cookies, nous ne suivons pas votre navigation entre les sites, et
			nous ne partageons aucune information avec des tiers.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-foreground">Analyse d'audience</h2>
		<p class="mt-4 text-foreground/75">
			Nous utilisons <a
				href="https://www.simpleanalytics.com"
				target="_blank"
				rel="noopener noreferrer"
				class="text-red-700 underline hover:text-red-500">Simple Analytics</a
			>, un service d'analyse respectueux de la vie privée. Simple Analytics :
		</p>
		<ul class="mt-4 list-inside list-disc space-y-2 text-foreground/75">
			<li>Ne collecte pas d'adresses IP</li>
			<li>N'utilise pas de cookies</li>
			<li>Ne suit pas les visiteurs entre les sites</li>
			<li>Est conforme au RGPD sans consentement requis</li>
		</ul>
		<p class="mt-4 text-foreground/75">
			Seules des données agrégées et anonymes sont collectées (nombre de visites, pages consultées,
			pays d'origine approximatif).
		</p>

		<h2 class="mt-8 text-xl font-semibold text-foreground">Formulaire de contact</h2>
		<p class="mt-4 text-foreground/75">
			Si vous utilisez le formulaire de contact, les informations que vous fournissez (nom, email,
			message) sont uniquement utilisées pour répondre à votre demande. Ces données ne sont pas
			stockées dans une base de données.
		</p>
		<p class="mt-4 text-foreground/75">
			L'envoi des emails est assuré par <a
				href="https://resend.com"
				target="_blank"
				rel="noopener noreferrer"
				class="text-red-700 underline hover:text-red-500">Resend</a
			>, un service conforme au RGPD. Resend conserve les métadonnées des emails (adresses, objet,
			contenu) pour permettre le suivi de livraison. Ces données sont supprimées dans les 90 jours
			suivant la fermeture du compte. Voir leur
			<a
				href="https://resend.com/legal/privacy-policy"
				target="_blank"
				rel="noopener noreferrer"
				class="text-red-700 underline hover:text-red-500">politique de confidentialité</a
			>.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-foreground">Vos droits</h2>
		<p class="mt-4 text-foreground/75">
			Conformément au RGPD, vous disposez d'un droit d'accès, de rectification et de suppression de
			vos données. Étant donné que nous ne collectons pas de données personnelles identifiables, ces
			droits s'appliquent uniquement aux éventuels échanges par email suite à une prise de contact.
		</p>

		<h2 class="mt-8 text-xl font-semibold text-foreground">Contact</h2>
		<p class="mt-4 text-foreground/75">
			Pour toute question concernant cette politique de confidentialité, vous pouvez me contacter
			via le <a href="{resolve('/')}#contact" class="text-red-700 underline hover:text-red-500"
				>formulaire de contact</a
			>.
		</p>

		<p class="mt-12 text-sm text-warm-700">Dernière mise à jour : décembre 2024</p>
	</div>

	<div class="mt-12 text-center">
		<a
			href={resolve('/')}
			class="inline-flex items-center gap-2 text-red-700 transition-colors hover:text-red-500"
		>
			← Retour à l'accueil
		</a>
	</div>
</Section>
