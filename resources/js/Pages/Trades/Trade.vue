<script setup>
import { ref, onMounted } from 'vue'
import { useForm } from '@inertiajs/vue3'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const currencies = ref([])

// Загружаем валюты
onMounted(async () => {
  const res = await axios.get('/api/currencies')
  currencies.value = res.data
})

// Форма создания оффера
const form = useForm({
  currency_id: '',
  title: '',
  description: '',
  price_per_unit: '',
  quantity: '',
})

// Отправка формы
const submit = () => {
  form.post('/offers')
}
</script>

<template>
  <div class="max-w-3xl mx-auto py-10">
    <h1 class="text-2xl font-bold mb-4">Создание оффера</h1>

    <form @submit.prevent="submit" class="space-y-4">
      <div>
        <label class="block font-semibold mb-1">Валюта</label>
        <select v-model="form.currency_id" class="w-full border p-2 rounded">
          <option disabled value="">Выберите валюту</option>
          <option v-for="currency in currencies" :key="currency.id" :value="currency.id">
            {{ currency.name }}
          </option>
        </select>
        <div v-if="form.errors.currency_id" class="text-red-500">{{ form.errors.currency_id }}</div>
      </div>

      <div>
        <label class="block font-semibold mb-1">Заголовок</label>
        <input v-model="form.title" type="text" class="w-full border p-2 rounded" />
        <div v-if="form.errors.title" class="text-red-500">{{ form.errors.title }}</div>
      </div>

      <div>
        <label class="block font-semibold mb-1">Описание</label>
        <textarea v-model="form.description" class="w-full border p-2 rounded"></textarea>
        <div v-if="form.errors.description" class="text-red-500">{{ form.errors.description }}</div>
      </div>

      <div>
        <label class="block font-semibold mb-1">Цена за единицу(уточняйте в описании)</label>
        <input v-model="form.price_per_unit" type="number" class="w-full border p-2 rounded" step="0.01" />
        <div v-if="form.errors.price_per_unit" class="text-red-500">{{ form.errors.price_per_unit }}</div>
      </div>

      <div>
        <label class="block font-semibold mb-1">Количество</label>
        <input v-model="form.quantity" type="number" class="w-full border p-2 rounded" />
        <div v-if="form.errors.quantity" class="text-red-500">{{ form.errors.quantity }}</div>
      </div>

      <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">Создать</button>
    </form>
  </div>
</template>
<script>
import AppLayout from '@/Layouts/AppLayout.vue'
</script>