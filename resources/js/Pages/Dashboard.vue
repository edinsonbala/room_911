<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>

    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">Dashboard</h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100 dark:bg-gray-900">
                        <div class="text-center mb-6">
                            <h1 class="text-4xl font-bold text-gray-800 dark:text-white">Site Under Construction</h1>
                            <p class="mt-2 text-lg text-gray-600 dark:text-gray-400">We'll be here soon with our new
                                site. Stay
                                tuned!</p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
