<script setup lang="ts">
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
import { ref } from 'vue';
import { router } from '@inertiajs/vue3';
import Table from '@/Components/Table.vue';
import Select from '@/Components/Select.vue';
import TextInput from '@/Components/TextInput.vue';
import InputLabel from '@/Components/InputLabel.vue';

const props = defineProps<{
    employees: any;
    currentPage: any;
    lastPage: any;
    search: any;
    departments: Array<{ value: number; name: string }>;
}>();

const employees = ref(props.employees);
const currentPage = ref(props.currentPage);
const lastPage = ref(props.lastPage);
const departmentOptions = ref(props.departments || []);
const loading = ref(false);

const filter = ref({
    searchQuery: props.search || '',
    department_id: "",
    startDate: '',
    endDate: '',
});

const search = () => {
    loading.value = true;
    router.visit(route('employee.index', {
        search: filter.value.searchQuery,
        department_id: filter.value.department_id,
        start_date: filter.value.startDate,
        end_date: filter.value.endDate,
        page: 1
    }), {
        method: 'get',
        preserveState: true,
        onSuccess: (page) => {
            employees.value = page.props.employees;
            currentPage.value = page.props.currentPage;
            lastPage.value = page.props.lastPage;
            loading.value = false;
        },
        onError: () => {
            loading.value = false;
        }
    });
};

const clearFilter = () => {
    filter.value = {
        searchQuery: '',
        department_id: "",
        startDate: '',
        endDate: '',
    };
    search();
};

const loadPage = (page: number) => {
    if (page !== currentPage.value) {
        loading.value = true;
        router.visit(route('employee.index', {
            search: filter.value.searchQuery,
            department_id: filter.value.department_id,
            start_date: filter.value.startDate,
            end_date: filter.value.endDate,
            page
        }), {
            method: 'get',
            preserveState: true,
            onSuccess: (page) => {
                employees.value = page.props.employees;
                currentPage.value = page.props.currentPage;
                lastPage.value = page.props.lastPage;
                loading.value = false;
            },
            onError: () => {
                loading.value = false;
            }
        });
    }
};

const csvFileName = ref('');
const csvFile = ref<File | null>(null);

const handleFileChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (target.files && target.files.length > 0) {
        csvFile.value = target.files[0];
        csvFileName.value = csvFile.value.name;
        uploadCsv();
    }
};

const uploadCsv = () => {
    if (csvFile.value) {
        const formData = new FormData();
        formData.append('csv_file', csvFile.value);

        router.visit(route('employee.importCsv'), {
            method: 'post',
            data: formData,
            forceFormData: true,
            onFinish: () => {
                csvFileName.value = '';
                csvFile.value = null;
            },
            onError: (errors) => {
                alert('Error importing CSV file:\n' + Object.values(errors).join('\n'));
            },
            onSuccess: () => {
                alert('CSV file imported successfully.');
            },
        });
    }
};

</script>

<template>
    <Head title="Dashboard" />
    <AuthenticatedLayout>
        <template #header>
            <div class="flex justify-between">
                <h2 class="font-semibold text-xl text-gray-800 leading-tight">Employees</h2>
                <Link :href="route('employee.create')" class="btn btn-primary">New Employee</Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
                    <div class="flex flex-col md:flex-row md:items-center mb-10">
                        <div class="mb-4 md:mb-0 md:mr-4">
                            <TextInput v-model="filter.searchQuery" type="text" placeholder="Search employees"
                                class="border rounded px-4 py-2  mt-5" />
                        </div>
                        <div class="mb-4 md:mb-0 md:mr-4  mt-5 ">
                            <Select v-model="filter.department_id" :options="departmentOptions" />
                        </div>
                        <div class="mb-4 md:mb-0 md:mr-4">
                            <InputLabel for="startDate" value="Initial access date" />
                            <TextInput v-model="filter.startDate" type="date" placeholder="Start date"
                                class="border rounded px-4 py-2" />
                        </div>
                        <div class="mb-4 md:mb-0 md:mr-4">
                            <InputLabel for="endDate" value="Final access date" />
                            <TextInput v-model="filter.endDate" type="date" placeholder="End date"
                                class="border rounded px-4 py-2" />
                        </div>
                        <div class="mb-4 md:mb-0 mt-4">
                            <button @click="search"
                                class="bg-gray-400 text-white px-4 py-1 rounded hover:bg-gray-600 flex items-center gap-1">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor"
                                    class="size-4">
                                    <path
                                        d="M14 2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v2.172a2 2 0 0 0 .586 1.414l2.828 2.828A2 2 0 0 1 6 9.828v4.363a.5.5 0 0 0 .724.447l2.17-1.085A2 2 0 0 0 10 11.763V9.829a2 2 0 0 1 .586-1.414l2.828-2.828A2 2 0 0 0 14 4.172V2Z" />
                                </svg>
                                Filter
                            </button>
                        </div>
                        <div class="mb-4 md:mb-0 mt-4 ml-4">
                            <button @click="clearFilter"
                                class="bg-gray-400 text-white px-4 py-1 rounded hover:bg-gray-600 flex items-center gap-1">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor"
                                    class="size-4">
                                    <path
                                        d="M5.28 4.22a.75.75 0 0 0-1.06 1.06L6.94 8l-2.72 2.72a.75.75 0 1 0 1.06 1.06L8 9.06l2.72 2.72a.75.75 0 1 0 1.06-1.06L9.06 8l2.72-2.72a.75.75 0 0 0-1.06-1.06L8 6.94 5.28 4.22Z" />
                                </svg>
                                Clear filter
                            </button>
                        </div>
                        <div class="mb-4 md:mb-0 mt-4 ml-4">
                            <label class="bg-gray-400 text-white px-4 py-1 rounded hover:bg-gray-600 flex items-center gap-1 cursor-pointer"
                                for="csvInput">
                  
                                {{ csvFileName || 'Import CSV' }}
                            </label>
                            <input type="file" id="csvInput" accept=".csv" @change="handleFileChange" style="display: none;">
                        </div>
                    </div>
                    <Table :employees="employees" :currentPage="currentPage" :lastPage="lastPage"
                        :searchQuery="filter.searchQuery" @page-change="loadPage" />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
