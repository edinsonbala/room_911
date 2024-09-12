<script setup lang="ts">
import { ref, onMounted } from 'vue';

const model = defineModel<string>({ required: true });
const props = defineProps<{
  options: { value: number | string, name: string }[];
}>();

const selectRef = ref<HTMLSelectElement | null>(null);

onMounted(() => {
  if (selectRef.value?.hasAttribute('autofocus')) {
    selectRef.value.focus();
  }
});

defineExpose({ focus: () => selectRef.value?.focus() });

const handleChange = (event: Event) => {
  const target = event.target as HTMLSelectElement;
  model.value = target.value;
};
</script>

<template>
  <select
    class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm"
    :value="model"
    @change="handleChange"
    ref="selectRef"
  >
    <option value="" disabled>Select an option</option>
    <option v-for="option in props.options" :key="option.value" :value="option.value">
      {{ option.name }}
    </option>
  </select>
</template>
