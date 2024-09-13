<script setup lang="ts">
import { ref } from 'vue';
import { useForm } from '@inertiajs/vue3';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputLabel from '@/Components/InputLabel.vue';
import TextInput from '@/Components/TextInput.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import InputError from '@/Components/InputError.vue';
import { Head,usePage } from '@inertiajs/vue3';

const form = useForm({
    internal_id: '',
});
const page = usePage();
const message = ref('');
const messageType = ref('');

const submit = (e: Event) => {
    e.preventDefault();
    
    form.post(route('employee.auth'), {
        onSuccess: (response) => {
            const resp: any = page.props;
            if(resp.success){
                messageType.value = 'success';
                message.value =resp.message;
            }else{
                messageType.value = 'error';
                message.value =resp.message;
            }
        },
        onError: (errors) => {
            message.value = 'An error occurred: ' + Object.values(errors).flat().join(', ');
            messageType.value = 'error';
        }
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Authentication" />

        <div v-if="message" :class="{'text-green-600': messageType === 'success', 'text-red-600': messageType === 'error'}" class="mb-4 font-medium text-sm">
            <div class="flex items-center">
                <svg v-if="messageType === 'success'" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                    <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm13.36-1.814a.75.75 0 1 0-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 0 0-1.06 1.06l2.25 2.25a.75.75 0 0 0 1.14-.094l3.75-5.25Z" clip-rule="evenodd" />
                </svg>
                <svg v-if="messageType === 'error'" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                    <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12ZM12 8.25a.75.75 0 0 1 .75.75v3.75a.75.75 0 0 1-1.5 0V9a.75.75 0 0 1 .75-.75Zm0 8.25a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z" clip-rule="evenodd" />
                </svg>
                <span class="ml-4">{{ message }}</span>
            </div>
        </div>

        <form @submit.prevent="submit">
            <div>
                <InputLabel for="internal_id" value="Internal ID" />
                <TextInput
                    id="internal_id"
                    type="text"
                    class="mt-1 block w-full"
                    v-model="form.internal_id"
                    required
                    autofocus
                    autocomplete="off"
                />
                <InputError class="mt-2" :message="form.errors.internal_id" />
            </div>

            <div class="flex justify-center mt-4">
                <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Authenticate
                </PrimaryButton>
            </div>
        </form>
    </GuestLayout>
</template>
