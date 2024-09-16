<script setup lang="ts">
import { computed } from 'vue';
import { usePage, router } from '@inertiajs/vue3';
import { defineProps } from 'vue';

const props:any = defineProps({
    users: Object,
    search: String
});

const fetchPage = (page: number) => {
    router.get(route('user.index'), { search: props.search, page });
};
const hasPreviousPage = computed(() => props.users?.prev_page_url !== null);
const hasNextPage = computed(() => props.users?.next_page_url !== null);

</script>

<template>
    <table class="min-w-full divide-y divide-gray-200">
        <thead>
            <tr>
                <th class="text-center">ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="user in props.users.data" :key="user.id">
                <td class="text-center">{{ user.id }}</td>
                <td class="text-center">{{ user.name }}</td>
                <td class="text-center">{{ user.email }}</td>
                <td class="flex justify-between">
                    <Link :href="route('employee.edit', user.id)" role="button"
                        class="bg-gray-400 text-white px-4 rounded hover:bg-gray-600 flex items-center gap-1">
                    <svg xmlns="http://www.w3.org/2000/svg" style="width:12px;" viewBox="0 0 16 16" fill="currentColor"
                        class="size-4">
                        <path fill-rule="evenodd"
                            d="M13.836 2.477a.75.75 0 0 1 .75.75v3.182a.75.75 0 0 1-.75.75h-3.182a.75.75 0 0 1 0-1.5h1.37l-.84-.841a4.5 4.5 0 0 0-7.08.932.75.75 0 0 1-1.3-.75 6 6 0 0 1 9.44-1.242l.842.84V3.227a.75.75 0 0 1 .75-.75Zm-.911 7.5A.75.75 0 0 1 13.199 11a6 6 0 0 1-9.44 1.241l-.84-.84v1.371a.75.75 0 0 1-1.5 0V9.591a.75.75 0 0 1 .75-.75H5.35a.75.75 0 0 1 0 1.5H3.98l.841.841a4.5 4.5 0 0 0 7.08-.932.75.75 0 0 1 1.025-.273Z"
                            clip-rule="evenodd" />
                    </svg>
                    <span>Update</span>
                    </Link>


                </td>
            </tr>
        </tbody>
    </table>
    <div class="flex justify-center  mt-4  items-center  gap-1 ">
        <button :disabled="!hasPreviousPage" @click="fetchPage(props.users.current_page - 1)" class="btn btn-secondary">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path fill-rule="evenodd"
                    d="M9.78 4.22a.75.75 0 0 1 0 1.06L7.06 8l2.72 2.72a.75.75 0 1 1-1.06 1.06L5.47 8.53a.75.75 0 0 1 0-1.06l3.25-3.25a.75.75 0 0 1 1.06 0Z"
                    clip-rule="evenodd" />
            </svg>
        </button>
        <button :disabled="!hasNextPage" @click="fetchPage(props.users.current_page + 1)" class="btn btn-secondary">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path fill-rule="evenodd"
                    d="M6.22 4.22a.75.75 0 0 1 1.06 0l3.25 3.25a.75.75 0 0 1 0 1.06l-3.25 3.25a.75.75 0 0 1-1.06-1.06L8.94 8 6.22 5.28a.75.75 0 0 1 0-1.06Z"
                    clip-rule="evenodd" />
            </svg>
        </button>
    </div>
</template>
<style scoped>
/* Add styles as needed */
table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    border: 1px solid #ddd;
    padding: 8px;
}

th {
    background-color: #f4f4f4;
}
</style>
