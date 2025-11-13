<script lang="ts">
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { Textarea } from '$lib/components/ui/textarea';
	import { type Snippet } from 'svelte';

	interface Props {
		id: string;
		label: string;
		name: string;
		type?: 'text' | 'email' | 'textarea';
		placeholder?: string;
		required?: boolean;
		rows?: number;
	}

	let {
		id,
		label,
		name,
		type = 'text',
		placeholder = '',
		required = false,
		rows = 5
	}: Props = $props();
</script>

<div class="space-y-2">
	<Label for={id}>{label}</Label>
	{#if type === 'textarea'}
		<Textarea {id} {name} {placeholder} {rows} {required} />
	{:else}
		<Input {id} {name} type={type} {placeholder} {required} />
	{/if}
</div>
