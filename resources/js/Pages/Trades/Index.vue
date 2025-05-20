<script setup>
import { ref, computed } from 'vue'
import { useForm, router } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({
  offers: Array,
  categories: Array,
  filters: Object,
})

const filters = ref({
  category_id: props.filters?.category_id || '',
  search: props.filters?.search || '',
})

// Покупка
const selectedOffer = ref(null)
const form = useForm({
  offer_id: '',
  quantity: 1,
})

const buy = (offer) => {
  selectedOffer.value = offer
  form.offer_id = offer.id
  form.quantity = 1
}

// Форма создания оффера
const createForm = useForm({
  title: '',
  description: '',
  price_per_unit: '',
  quantity: '',
  currency_id: '',
})

// Отфильтрованные офферы
const filteredOffers = computed(() => {
  return props.offers.filter((offer) => {
    const matchesCategory =
      !filters.value.category_id || offer.category_id == filters.value.category_id
    const matchesSearch =
      !filters.value.search || offer.title.toLowerCase().includes(filters.value.search.toLowerCase())

    return matchesCategory && matchesSearch
  })
})

// Отправка фильтров
const submitFilter = () => {
  router.get('/offers', filters.value, {
    preserveState: true,
    preserveScroll: true,
  })
}
</script>


<template>
  <div class="max-w-4xl mx-auto py-10">

    <div class="max-w-4xl mx-auto py-10">
    <div class="flex justify-between items-center">
      <h2 class="text-lg font-medium leading-6 text-gray-900">Активные офферы</h2>
      <Link
        href="/offers/add"
        class="inline-flex items-center rounded-md border border-transparent bg-cyan-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
      >
        Добавить новый оффер
      </Link>
    </div>

    <!-- Фильтры -->
    <div class="mt-6 flex flex-col gap-4 sm:flex-row sm:items-end sm:gap-6">
      <div class="flex-1">
        <label for="categoryFilter" class="block font-semibold mb-1">Фильтр по категории</label>
        <select id="categoryFilter" v-model="filters.category_id" @change="submitFilter" class="border p-2 rounded w-full">
          <option value="">Все категории</option>
          <option v-for="category in categories" :key="category.id" :value="category.id">{{ category.name }}</option>
        </select>
      </div>
      <div class="flex-1">
        <label for="search" class="block font-semibold mb-1">Поиск по названию</label>
        <input
          type="text"
          id="search"
          v-model="filters.search"
          @keyup.enter="submitFilter"
          class="border p-2 rounded w-full"
          placeholder="Введите название оффера"
        />
      </div>
    </div>

  <div class="mx-auto max-w-4xl">
    <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
      <table class="min-w-full divide-y divide-gray-300">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Название</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Описание</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Цена за штуку</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Всего доступно</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Продавец</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Действие</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200 bg-white">
          <tr v-for="offer in offers" :key="offer.id">
            <td class="px-6 py-4 text-sm text-gray-900">{{ offer.title }}</td>
            <td class="px-6 py-4 text-sm text-gray-900">{{ offer.description }}</td>
            <td class="px-6 py-4 text-sm text-gray-500">{{ offer.price_per_unit }} </td>
            <td class="px-6 py-4 text-sm text-gray-500">{{ offer.quantity }} {{ offer.currency.name }}</td>
            <td class="px-6 py-4 text-sm text-gray-500">{{ offer.user.name }}</td>
            <td class="px-6 py-4 text-sm">
              <button @click="buy(offer)" class="bg-cyan-600 text-white px-3 py-1 rounded text-sm hover:bg-cyan-700">
                Купить
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>



    <!-- Форма покупки -->
    <div v-if="selectedOffer" class="mt-6 border-t pt-4">
      <h2 class="text-lg font-semibold mb-2">Покупка: {{ selectedOffer.title }}</h2>
      <form @submit.prevent="form.post('/deals')" class="space-y-2">
        <div>
          <label class="block font-semibold">Количество</label>
          <input type="number" v-model="form.quantity" class="border p-2 rounded w-full" />
          <div v-if="form.errors.quantity" class="text-red-600">{{ form.errors.quantity }}</div>
        </div>
        <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded">Подтвердить</button>
      </form>
    </div>

    <!-- Форма создания оффера -->
    <div class="mt-12 border-t pt-6">
      <h2 class="text-xl font-semibold mb-4">Создать оффер</h2>
      <form @submit.prevent="createForm.post('/offers')" class="space-y-4">
        <div>
          <label>Заголовок</label>
          <input type="text" v-model="createForm.title" class="border p-2 rounded w-full" />
          <div v-if="createForm.errors.title" class="text-red-600">{{ createForm.errors.title }}</div>
        </div>
        <div>
          <label>Описание</label>
          <textarea v-model="createForm.description" class="border p-2 rounded w-full"></textarea>
        </div>
        <div>
          <label>Цена за единицу</label>
          <input type="number" v-model="createForm.price_per_unit" class="border p-2 rounded w-full" step="0.01" />
        </div>
        <div>
          <label>Количество</label>
          <input type="number" v-model="createForm.quantity" class="border p-2 rounded w-full" />
        </div>
        <div>
          <label>Валюта</label>
          <select v-model="createForm.currency_id" class="border p-2 rounded w-full">
            <option value="">Выберите</option>
            <option v-for="currency in currencies" :key="currency.id" :value="currency.id">
              {{ currency.name }}
            </option>
          </select>
        </div>
        <button type="submit" class=" bg-cyan-600 text-white px-4 py-2 hover:bg-cyan-700 rounded">Создать оффер</button>
      </form>
    </div>
  </div>
</template>
