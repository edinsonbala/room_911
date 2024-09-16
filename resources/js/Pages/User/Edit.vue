<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm,usePage } from '@inertiajs/vue3';
import InputLabel from '@/Components/InputLabel.vue';
import InputError from '@/Components/InputError.vue';
import TextInput from '@/Components/TextInput.vue'; // Make sure to import TextInput
import Checkbox from '@/Components/Checkbox.vue';
import Select from '@/Components/Select.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
const page = usePage();
const user: any = page.props.user;

const form = useForm({
    name: user.name,
    email:user.email,
});

const submit = (e: Event) => {
    e.preventDefault();
     form.put(route('user.update', { id: user.id }), {
        onSuccess: () => {
            alert('User update successfully.');
        },
        onError: (errors) => {
            alert('Error update user:\n' + Object.values(errors).join('\n'));
        }
    });

    console.log("Form submission halted", form.data());
};
</script>

<template>
    <Head title="New Employees" />
    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-between">
                <h2 class="font-semibold text-xl text-gray-800 leading-tight">New User</h2>
                <Link :href="route('employee.index')">List Users</Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex justify-center bg-white overflow-hidden shadow-sm sm:rounded-lg w-1/2 mx-auto">
                    <form class="w-full py-5 px-10" @submit="submit">
                        <InputLabel class="py-2"  for="name" value="Name" />
                        <TextInput id="name" type="text" class="mt-1 block w-full" v-model="form.name"
                                   required autofocus autocomplete="Name" />
                        <InputError class="mt-2" :message="form.errors.name" />

                        <InputLabel  class="py-2" for="email" value="Email" />
                        <TextInput id="email" type="email" class="mt-1 block w-full" v-model="form.email"
                                   required autofocus autocomplete="email" />
                        <InputError class="mt-2" :message="form.errors.email" />
                        <div class="flex justify-center mt-4">
                            <PrimaryButton>
                                Update
                            </PrimaryButton>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

