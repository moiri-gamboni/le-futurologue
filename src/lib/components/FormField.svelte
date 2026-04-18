<script lang="ts">
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { Textarea } from '$lib/components/ui/textarea';
	import type { HTMLInputAttributes, HTMLTextareaAttributes } from 'svelte/elements';

	interface Props {
		id: string;
		label: string;
		name: string;
		type?: 'text' | 'email' | 'textarea';
		placeholder?: string;
		required?: boolean;
		rows?: number;
		value?: string;
		autocomplete?: HTMLInputAttributes['autocomplete'] | HTMLTextareaAttributes['autocomplete'];
	}

	let {
		id,
		label,
		name,
		type = 'text',
		placeholder = '',
		required = false,
		rows = 5,
		value = '',
		autocomplete
	}: Props = $props();
</script>

<div class="space-y-2">
	<Label for={id}>{label}</Label>
	{#if type === 'textarea'}
		<Textarea {id} {name} {placeholder} {rows} {required} {value} {autocomplete} />
	{:else}
		<Input {id} {name} {type} {placeholder} {required} {value} {autocomplete} />
	{/if}
</div>
