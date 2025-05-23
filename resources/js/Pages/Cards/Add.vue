<script setup>
import { useForm } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const form = useForm({
  name: '',
  number: '',
  expiry: '',
  type: '',
  primary: false,
})

const submit = () => {
  form.post('/cards', {
    onSuccess: () => form.reset(),
  })
}
</script>

<template>
  <div class="max-w-2xl mx-auto mt-10 bg-white shadow-md rounded-lg p-6 space-y-6">
    <h2 class="text-2xl font-bold text-gray-800">Добавить карту</h2>

    <form @submit.prevent="submit" class="space-y-5">
      <div>
        <label class="block text-sm font-medium text-gray-700">Название карты</label>
        <input
          type="text"
          v-model="form.name"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
          placeholder="Например, Моя VISA"
          required
        />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700">Номер карты</label>
        <input
          type="text"
          v-model="form.number"
          maxlength="19"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
          placeholder="•••• •••• •••• 1234"
          required
        />
      </div>

      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Срок действия</label>
          <input
            type="text"
            v-model="form.expiry"
            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
            placeholder="MM/YY"
            required
          />
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Тип карты</label>
          <select
            v-model="form.type"
            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
            required
          >
            <option value="">Выберите</option>
            <option value="VISA">VISA</option>
            <option value="MasterCard">MasterCard</option>
            <option value="МИР">МИР</option>
          </select>
        </div>
      </div>

      <div class="flex items-center">
        <input
          id="primary"
          type="checkbox"
          v-model="form.primary"
          class="h-4 w-4 text-cyan-600 focus:ring-cyan-500 border-gray-300 rounded"
        />
        <label for="primary" class="ml-2 block text-sm text-gray-700">Сделать основной</label>
      </div>

      <div class="flex justify-end">
        <button
          type="submit"
          class="bg-cyan-600 text-white px-5 py-2 rounded-md shadow hover:bg-cyan-700 transition"
        >
          Сохранить карту
        </button>
      </div>
    </form>
  </div>
</template>