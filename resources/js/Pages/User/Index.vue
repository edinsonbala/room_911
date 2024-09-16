<script setup lang="ts">
import { ref } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { usePage, router } from '@inertiajs/vue3';
import TableUser from '@/Components/TableUser.vue';

interface PaginatedUsers {
    data: User[];
    prev_page_url: string | null;
    next_page_url: string | null;
    current_page: number;
}

interface User {
    id: number;
    name: string;
    email: string;
}

const page = usePage();
const search :any=page.props.search;
const users: any = page.props.users;
const searchUsers = () => {
    router.get(route('user.index'), { search: search });
};
</script>

<template>
    <Head title="Users" />
    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-between items-center mb-6">
                <h2 class="font-semibold text-2xl text-gray-800 leading-tight">Users</h2>
                <Link :href="route('user.create')" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg shadow">
                    New User
                </Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <div class="flex items-center mb-4 space-x-2">
                        <input
                            v-model="search"
                            placeholder="Search"
                            class="border-gray-300 focus:border-blue-500 focus:ring-blue-500 rounded-md shadow-sm w-1/4 py-2 px-4"
                        />
                        <button
                            @click="searchUsers"
                            class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg shadow flex items-center space-x-2"
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                            </svg>
                        </button>
                    </div>

                    <TableUser :users="users" :search="search" />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
