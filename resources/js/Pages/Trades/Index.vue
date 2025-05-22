<script setup>
import { ref, computed } from 'vue'
import { useForm, router } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({
  offers: Array,
  categories: Array,
  gameCategories: {
    type: Array,
    default: () => []
  },
  games: Array,
  servers: Array,
  
  filters: Object,
})
const showCreateModal = ref(false)


const filters = ref({
  category_id: props.filters?.category_id || '',
  game_category_id: props.filters?.game_category_id || '',
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
  category_id: '',
  game_category_id: '',
  game_id: '',
  server_id: '',
  price: '',
  quantity: '',
 
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
      <!-- Кнопка для открытия модалки -->
<!-- Кнопка открытия -->
<button
  @click="showCreateModal = true"
  class="mt-4 bg-cyan-600 text-white px-4 py-2 rounded shadow hover:bg-cyan-700 transition"
>
  Добавить оффер
</button>

<!-- Модальное окно -->
<div
  v-if="showCreateModal"
  class="fixed inset-0 bg-black bg-opacity-40 backdrop-blur-sm flex justify-center items-center z-50"
>
  <div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6 space-y-4">
    <div class="flex justify-between items-center">
      <h2 class="text-lg font-semibold text-gray-800">Новый оффер</h2>
      <button @click="showCreateModal = false" class="text-gray-400 hover:text-gray-600">&times;</button>
    </div>

    <form @submit.prevent="createForm.post('/offers', { onSuccess: () => showCreateModal = false })" class="space-y-3">
      <div>
        <label class="block text-sm font-medium text-gray-700">Заголовок</label>
        <input v-model="createForm.title" type="text" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500" />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700">Описание</label>
        <textarea v-model="createForm.description" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500" rows="2" />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700">Категория</label>
        <select v-model="createForm.category_id" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
          <option value="">Выберите</option>
          <option v-for="c in categories" :key="c.id" :value="c.id">{{ c.name }}</option>
        </select>
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700">Категория игры</label>
        <select v-model="createForm.game_category_id" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
          <option value="">Выберите</option>
          <option v-for="category in gameCategories" :key="category?.id" :value="category?.id">
            {{ category?.name ?? 'Без названия' }}
          </option>
        </select>
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700">Игра</label>
        <select v-model="createForm.game_id" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
          <option value="">Выберите</option>
          <option v-for="g in games" :key="g.id" :value="g.id">{{ g.name }}</option>
        </select>
      </div>

      <div v-if="servers.length">
        <label class="block text-sm font-medium text-gray-700">Сервер</label>
        <select v-model="createForm.server_id" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
          <option value="">Выберите</option>
          <option v-for="s in servers" :key="s.id" :value="s.id">{{ s.name }}</option>
        </select>
      </div>

      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Цена</label>
          <input v-model="createForm.price" type="number" step="0.01" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500" />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">Количество</label>
          <input v-model="createForm.quantity" type="number" class="mt-1 w-full border-gray-300 rounded-md shadow-sm focus:ring-cyan-500 focus:border-cyan-500" />
        </div>
      </div>

      <div class="flex justify-end pt-2">
        <button @click="showCreateModal = false" type="button" class="mr-3 text-sm text-gray-600 hover:underline">Отмена</button>
        <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded-md hover:bg-cyan-700 transition">Создать</button>
      </div>
    </form>
  </div>
</div>
</div>
    <!-- Фильтры -->
    <div class="mt-8 bg-white rounded-xl shadow p-6 space-y-4 sm:space-y-0 sm:flex sm:items-end sm:justify-between sm:gap-6">
  <!-- Категория -->
  <div class="flex-1">
    <label for="categoryFilter" class="block text-sm font-semibold text-gray-700 mb-1">Категория</label>
    <select
      id="categoryFilter"
      v-model="filters.category_id"
      @change="submitFilter"
      class="w-full rounded-md border border-gray-300 bg-white p-2 shadow-sm focus:border-cyan-600 focus:ring-cyan-600"
    >
      <option value="">Все категории</option>
      <option v-for="category in categories" :key="category.id" :value="category.id">
        {{ category.name }}
      </option>
    </select>
  </div>

  <!-- Категория игры -->
  <div class="flex-1">
    <label for="gameCategoryFilter" class="block text-sm font-semibold text-gray-700 mb-1">Категория игры</label>
    <select
      id="gameCategoryFilter"
      v-model="filters.game_category_id"
      @change="submitFilter"
      class="w-full rounded-md border border-gray-300 bg-white p-2 shadow-sm focus:border-cyan-600 focus:ring-cyan-600"
    >
      <option value="">Все игровые категории</option>
      <option v-for="category in gameCategories" :key="category?.id" :value="category?.id">
        {{ category?.name ?? 'Без названия' }}
      </option>
    </select>
  </div>

  <!-- Поиск -->
  <div class="flex-1">
    <label for="search" class="block text-sm font-semibold text-gray-700 mb-1">Поиск по названию</label>
    <input
      type="text"
      id="search"
      v-model="filters.search"
      @keyup.enter="submitFilter"
      placeholder="Введите название оффера"
      class="w-full rounded-md border border-gray-300 bg-white p-2 shadow-sm focus:border-cyan-600 focus:ring-cyan-600"
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
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Игра/Услуга</th>
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
            <td class="px-6 py-4 text-sm text-gray-900">{{ offer.game_name ?? '—' }}</td>
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
   
    </div>
 
</template>
