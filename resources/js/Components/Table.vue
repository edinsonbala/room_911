<template>
  <div>
    <table v-if="employees.length">
      <thead>
        <tr>
          <th class="text-center">Employee ID</th>
          <th class="text-center">Firstname</th>
          <th class="text-center">Lastname</th>
          <th class="text-center">Department</th>
          <th class="text-center">Total Access</th>
          <th class="text-center">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="employee in employees" :key="employee.id">
          <td class="text-center">{{ employee.id }}</td>
          <td class="text-center">{{ employee.first_name }}</td>
          <td class="text-center">{{ employee.last_name }}</td>
          <td class="text-center">{{ employee.department.name }}</td>
          <td class="text-center">{{ employee.access_attempts_count }}</td>
          <td class="flex justify-between">
            <Link :href="route('employee.edit', employee.id)" role="button" class="bg-gray-400 text-white px-4 rounded hover:bg-gray-600 flex items-center gap-1">
              <svg xmlns="http://www.w3.org/2000/svg" style="width:12px;" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path fill-rule="evenodd" d="M13.836 2.477a.75.75 0 0 1 .75.75v3.182a.75.75 0 0 1-.75.75h-3.182a.75.75 0 0 1 0-1.5h1.37l-.84-.841a4.5 4.5 0 0 0-7.08.932.75.75 0 0 1-1.3-.75 6 6 0 0 1 9.44-1.242l.842.84V3.227a.75.75 0 0 1 .75-.75Zm-.911 7.5A.75.75 0 0 1 13.199 11a6 6 0 0 1-9.44 1.241l-.84-.84v1.371a.75.75 0 0 1-1.5 0V9.591a.75.75 0 0 1 .75-.75H5.35a.75.75 0 0 1 0 1.5H3.98l.841.841a4.5 4.5 0 0 0 7.08-.932.75.75 0 0 1 1.025-.273Z" clip-rule="evenodd" />
              </svg>
              <span>Update</span>
            </Link>

            <button @click="toggleRoomAccess(employee.id)" class="bg-gray-400 text-white px-4 rounded hover:bg-gray-600 flex items-center gap-1">
              <svg v-if="employee.room_access" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4">
                <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm2.78-4.22a.75.75 0 0 1-1.06 0L8 9.06l-1.72 1.72a.75.75 0 1 1-1.06-1.06L6.94 8 5.22 6.28a.75.75 0 0 1 1.06-1.06L8 6.94l1.72-1.72a.75.75 0 1 1 1.06 1.06L9.06 8l1.72 1.72a.75.75 0 0 1 0 1.06Z" clip-rule="evenodd" />
              </svg>
              <svg v-else xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4">
                <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm3.844-8.791a.75.75 0 0 0-1.188-.918l-3.7 4.79-1.649-1.833a.75.75 0 1 0-1.114 1.004l2.25 2.5a.75.75 0 0 0 1.15-.043l4.25-5.5Z" clip-rule="evenodd" />
              </svg>
              {{ employee.room_access ? "Disabled" : "Enable" }}
            </button>
            <button   @click="downloadAccessHistory(employee.id)" class="bg-yellow-400 text-white px-4 py-0 rounded hover:bg-yellow-600 flex items-center gap-1">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path fill-rule="evenodd" d="M4 2a1.5 1.5 0 0 0-1.5 1.5v9A1.5 1.5 0 0 0 4 14h8a1.5 1.5 0 0 0 1.5-1.5V6.621a1.5 1.5 0 0 0-.44-1.06L9.94 2.439A1.5 1.5 0 0 0 8.878 2H4Zm1 5.75A.75.75 0 0 1 5.75 7h4.5a.75.75 0 0 1 0 1.5h-4.5A.75.75 0 0 1 5 7.75Zm0 3a.75.75 0 0 1 .75-.75h4.5a.75.75 0 0 1 0 1.5h-4.5a.75.75 0 0 1-.75-.75Z" clip-rule="evenodd" />
              </svg>
              History
            </button>
            <button  @click="deleteEmployee(employee.id)" class="bg-red-500 text-white px-4 py-1 rounded hover:bg-red-600  flex items-center gap-1">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path d="M2 3a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3Z" />
                <path fill-rule="evenodd" d="M13 6H3v6a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V6ZM5.72 7.47a.75.75 0 0 1 1.06 0L8 8.69l1.22-1.22a.75.75 0 1 1 1.06 1.06L9.06 9.75l1.22 1.22a.75.75 0 1 1-1.06 1.06L8 10.81l-1.22 1.22a.75.75 0 0 1-1.06-1.06l1.22-1.22-1.22-1.22a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
              </svg>
              Delete
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-if="employees.length"class="flex justify-center  mt-4  items-center  gap-1 ">
      <button @click="prevPage" :disabled="currentPage <= 1">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
          <path fill-rule="evenodd" d="M9.78 4.22a.75.75 0 0 1 0 1.06L7.06 8l2.72 2.72a.75.75 0 1 1-1.06 1.06L5.47 8.53a.75.75 0 0 1 0-1.06l3.25-3.25a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd" />
        </svg>

      </button>
      <button @click="nextPage" :disabled="currentPage >= lastPage">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
          <path fill-rule="evenodd" d="M6.22 4.22a.75.75 0 0 1 1.06 0l3.25 3.25a.75.75 0 0 1 0 1.06l-3.25 3.25a.75.75 0 0 1-1.06-1.06L8.94 8 6.22 5.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
      </button>
    </div>

    <div v-if="loading">Loading...</div>

    <div v-if="!employees.length && !loading">
      <p>No employees found.</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Link } from '@inertiajs/vue3';
import { router } from '@inertiajs/vue3'; 

export default defineComponent({
  components: {
    PrimaryButton,
    Link, 
  },
  props: {
    employees: {
      type: Array as PropType<Array<{
        id: number;
        first_name: string;
        last_name: string;
        department: {
          name: string;
        };
        access_attempts_count: number;
        room_access: boolean; // Añade esto para que el tipo coincida
      }>>,
      required: true,
    },
    currentPage: {
      type: Number,
      required: true,
    },
    lastPage: {
      type: Number,
      required: true,
    },
    searchQuery: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      loading: false,
    };
  },
  methods: {
    prevPage() {
      if (this.currentPage > 1) {
        this.$emit('page-change', this.currentPage - 1);
      }
    },
    nextPage() {
      if (this.currentPage < this.lastPage) {
        this.$emit('page-change', this.currentPage + 1);
      }
    },
    toggleRoomAccess(employeeId: number) {
      router.post(route('employees.toggle-room-access', { id: employeeId }), {}, {
        onSuccess: (response:any) => {
          window.location.reload(); 
        },
        onError: (errors) => {
          console.error('Error updating room access status', errors);
        }
      });
    },
    downloadAccessHistory(employeeId: number) {
      window.location.href = route('employee.historyPdf', { id: employeeId });
    },
    deleteEmployee(employeeId: number) {
      router.delete(route('employee.destroy', { id: employeeId }), {
        onSuccess: () => {
          window.location.reload();
        },
        onError: (errors) => {
          console.error('Error deleting employee', errors);
        }
      });
    }
  },
});
</script>

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
