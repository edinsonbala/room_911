<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import InputLabel from '@/Components/InputLabel.vue';
import InputError from '@/Components/InputError.vue';
import TextInput from '@/Components/TextInput.vue'; 
import Checkbox from '@/Components/Checkbox.vue';
import Select from '@/Components/Select.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { ref } from 'vue';

const page = usePage();
const employee: any = page.props.employee;
const departmentOptions: any = page.props.departments;
const form = useForm({
    first_name: employee.first_name,
    last_name: employee.last_name,
    internal_id: employee.internal_id,
    department_id: employee.department_id,
    room_access: employee.room_access,
});

const submit = (e: Event) => {
    e.preventDefault();
    
    form.put(route('employee.update', { id: employee.id }), {
        onSuccess: () => {
            alert('Employee updated successfully.');
        },
        onError: (errors) => {
            alert('Error updating employee:\n' + Object.values(errors).join('\n'));
        }
    });
    
    console.log("Form submission halted", form.data());
};
</script>

<template>
    <Head title="Update Employee" />
    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-between">
                <h2 class="font-semibold text-xl text-gray-800 leading-tight">Update Employee</h2>
                <Link :href="route('employee.index')">List Employees</Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex justify-center bg-white overflow-hidden shadow-sm sm:rounded-lg w-1/2 mx-auto">
                    <form class="w-full py-5 px-10 " @submit="submit">
                        <InputLabel class="py-2" for="first_name" value="First name" />
                        <TextInput id="first_name" type="text" class="mt-1 block w-full" v-model="form.first_name"
                                   required autofocus autocomplete="First name" />
                        <InputError class="mt-2" :message="form.errors.first_name" />

                        <InputLabel   class="py-2" for="last_name" value="Last name" />
                        <TextInput id="last_name" type="text" class="mt-1 block w-full" v-model="form.last_name"
                                   required autofocus autocomplete="Last name" />
                        <InputError class="mt-2" :message="form.errors.last_name" />

                        <InputLabel  class="py-2" for="internal_id" value="Internal ID" />
                        <TextInput id="internal_id" type="text" class="mt-1 block w-full" v-model="form.internal_id"
                                   required autofocus autocomplete="ID" />
                        <InputError class="mt-2" :message="form.errors.internal_id" />

                        <div class="block mt-4">
                            <label class="flex items-center">
                                <Checkbox name="room_access" v-model:checked="form.room_access" />
                                <span class="ms-2 text-sm text-gray-600">Enable room access</span>
                            </label>
                        </div>
                        <InputError class="mt-2" :message="form.errors.room_access" />
                        <InputLabel class="mt-2"  for="department_id" value="Select a department" />
                        <Select  class="mt-4" v-model="form.department_id" :options="departmentOptions" />
                        <InputError class="mt-2" :message="form.errors.department_id" />
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
