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
const initialValues = {
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
};
const form = useForm(initialValues);

const submit = (e: Event) => {
    e.preventDefault();
    form.post(route('user.store'), {
        onSuccess: () => {
            alert('User created successfully.');
        },
        onError: (errors) => {
            alert('Error creating user:\n' + Object.values(errors).join('\n'));
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

                        <InputLabel  class="py-2" for="password" value="Password" />
                        <TextInput id="password" type="text" class="mt-1 block w-full" v-model="form.password"
                                   required autofocus autocomplete="ID" />
                        <InputError class="mt-2" :message="form.errors.password" />
                        <InputLabel  class="py-2" for="confirm_password" value="Confirm Password" />
                        <TextInput id="confirm_password" type="text" class="mt-1 block w-full" v-model="form.password_confirmation"
                                   required autofocus autocomplete="confirm password" />
                        <InputError class="mt-2" :message="form.errors.password_confirmation" />

                       
                      
                        <div class="flex justify-center mt-4">
                            <PrimaryButton>
                                Create
                            </PrimaryButton>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

