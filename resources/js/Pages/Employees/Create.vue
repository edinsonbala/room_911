<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import InputLabel from '@/Components/InputLabel.vue';
import InputError from '@/Components/InputError.vue';
import TextInput from '@/Components/TextInput.vue';  // Asegúrate de importar TextInput
import Checkbox from '@/Components/Checkbox.vue';
import Select from '@/Components/Select.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';

const inicialValues = {
    first_name: "",
    last_name: "",
    internal_id: "",
    department_id: "",
    room_access:false,
};

const departmentOptions = [
    { value: 1, name: 'HR' },
    { value: 2, name: 'Engineering' },
    { value: 3, name: 'Marketing' }
];

const form = useForm(inicialValues);

const submit = (e: Event) => {
   e.preventDefault();
   form.post(route('employee.store')); 
   console.log("Formulario detenido", form.data());
};
</script>

<template>
    <Head title="New Employees" />
    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-between">
                <h2 class="font-semibold text-xl text-gray-800 leading-tight">New Employees</h2>
                <Link :href="route('employee.index')">List Employees</Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex justify-center bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <form class="w-1/3 py-5" @submit="submit">
                        <InputLabel for="first_name" value="First name" />
                        <TextInput id="first_name" type="text" class="mt-1 block w-full" v-model="form.first_name"
                                   required autofocus autocomplete="First name" />
                        <InputError class="mt-2" :message="form.errors.first_name" />

                        <InputLabel for="last_name" value="Last name" />
                        <TextInput id="last_name" type="text" class="mt-1 block w-full" v-model="form.last_name"
                                   required autofocus autocomplete="Last name" />
                        <InputError class="mt-2" :message="form.errors.last_name" />

                        <InputLabel for="internal_id" value="Internal ID" />
                        <TextInput id="internal_id" type="text" class="mt-1 block w-full" v-model="form.internal_id"
                                   required autofocus autocomplete="ID" />
                        <InputError class="mt-2" :message="form.errors.internal_id" />

                        <div class="block mt-4">
                            <label class="flex items-center">
                                <Checkbox name="room_access" v-model="form.room_access" />
                                <span class="ms-2 text-sm text-gray-600">Enable room access</span>
                            </label>
                        </div>
                        <InputError class="mt-2" :message="form.errors.room_access" />
                        <InputLabel for="department_id" value="Select a department" />
                        <Select v-model="form.department_id" :options="departmentOptions" />
                        <InputError class="mt-2" :message="form.errors.department_id" />
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
