<script setup>
import { ref, computed, watch } from 'vue'
import { useForm, router } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({
  offers: Array,
  categories: Array,
  gameTypes: Array,
  games: Array,
  servers: Array,
  filters: Object,
  paymentMethods: Array,
})

const showCreateModal = ref(false)
const availableServers = ref([])

const filters = ref({
  category_id: props.filters?.category_id || '',
  game_type_id: props.filters?.game_type_id || '',
  search: props.filters?.search || '',
})

const selectedOffer = ref(null)
const form = useForm({
  offer_id: '',
  quantity: 1000,
  payment_method_id: '',
})

const createForm = useForm({
  title: '',
  description: '',
  category_id: '',
  game_type_id: '',
  game_id: '',
  server_id: '',
  price: '',
  quantity: '',
})

// При смене категории сбрасываем привязанные игровые поля
watch(() => createForm.category_id, () => {
  createForm.game_id = ''
  createForm.server_id = ''
  createForm.game_type_id = ''
})

// Игры по выбранной категории
const availableGames = computed(() => {
  if (!createForm.category_id) return []
  return props.games.filter(g => g.category_id == createForm.category_id)
})

// Автозаполнение типа игры + фильтрация серверов
watch(() => createForm.game_id, (gameId) => {
  if (!gameId) {
    availableServers.value = []
    createForm.server_id = ''
    createForm.game_type_id = ''
    return
  }

  const selectedGame = props.games.find(g => g.id === gameId)
  createForm.game_type_id = selectedGame?.game_type_id || ''

  availableServers.value = props.servers.filter(s => s.game_id === gameId)
})

const filteredOffers = computed(() => {
  return props.offers.filter((offer) => {
    const matchesCategory =
      !filters.value.category_id || offer.category_id == filters.value.category_id
    const matchesGameType =
      !filters.value.game_type_id || offer.game_type_id == filters.value.game_type_id
    const matchesSearch =
      !filters.value.search || offer.title.toLowerCase().includes(filters.value.search.toLowerCase())
    return matchesCategory && matchesGameType && matchesSearch
  })
})





const buy = (offer) => {
  selectedOffer.value = offer
  form.offer_id = offer.id
  form.quantity = 1
}

const submitFilter = () => {
  router.get('/offers', filters.value, {
    preserveState: true,
    preserveScroll: true,
  })
}

</script>
<template>
    <div class="max-w-4xl mx-auto py-10">
        
      <!-- Кнопка и модалка -->
      <div class="flex justify-between items-center">
        <h2 class="text-lg font-medium text-gray-900">Активные офферы</h2>
        <button
          @click="showCreateModal = true"
          class="mt-4 bg-cyan-600 text-white px-4 py-2 rounded shadow hover:bg-cyan-700 transition"
        >
          Добавить оффер
        </button>
      </div>
  
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
            <!-- Заголовок и описание -->
            <div>
              <label class="block text-sm font-medium text-gray-700">Заголовок</label>
              <input v-model="createForm.title" type="text" class="w-full border rounded-md shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Описание</label>
              <textarea v-model="createForm.description" rows="2" class="w-full border rounded-md shadow-sm" />
            </div>
  
            <!-- Категория -->
            <div>
              <label class="block text-sm font-medium text-gray-700">Категория</label>
              <select v-model="createForm.category_id" class="w-full border rounded-md shadow-sm">
                <option value="">Выберите</option>
                <option v-for="c in categories" :key="c.id" :value="c.id">{{ c.name }}</option>
              </select>
            </div>
  
            <!-- Тип игры (скрыт) -->
            <input type="hidden" v-model="createForm.game_type_id" />
  
            <!-- Игра (если есть доступные) -->
            <div v-if="availableGames.length">
              <label class="block text-sm font-medium text-gray-700">Игра</label>
              <select v-model="createForm.game_id" class="w-full border rounded-md shadow-sm">
                <option value="">Выберите</option>
                <option v-for="game in availableGames" :key="game.id" :value="game.id">{{ game.name }}</option>
              </select>
            </div>
  
            <!-- Серверы (если есть) -->
            <div v-if="availableServers.length">
              <label class="block text-sm font-medium text-gray-700">Сервер</label>
              <select v-model="createForm.server_id" class="w-full border rounded-md shadow-sm">
                <option value="">Выберите</option>
                <option v-for="s in availableServers" :key="s.id" :value="s.id">{{ s.name }}</option>
              </select>
            </div>
  
            <!-- Цена и количество -->
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700">Цена</label>
                <input v-model="createForm.price" type="number" step="0.01" class="w-full border rounded-md shadow-sm" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">Количество</label>
                <input v-model="createForm.quantity" type="number" class="w-full border rounded-md shadow-sm" />
              </div>
            </div>
  
            <!-- Кнопки -->
            <div class="flex justify-end pt-2">
              <button @click="showCreateModal = false" type="button" class="text-sm text-gray-600 hover:underline">Отмена</button>
              <button type="submit" class="ml-4 bg-cyan-600 text-white px-4 py-2 rounded-md hover:bg-cyan-700">Создать</button>
            </div>
          </form>
        </div>
      </div>
      <div class="mx-auto max-w-6xl mt-10">
  <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
    <table class="min-w-full divide-y divide-gray-300">
      <thead class="bg-gray-50">
        <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900 cursor-pointer" @click="sortBy('title')">
            Название
          </th>
          <th class="px-4 py-3 text-left text-sm font-semibold text-gray-900">Описание</th>
          <th class="px-4 py-3 text-left text-sm font-semibold text-gray-900">Игра</th>
          <th class="px-4 py-3 text-left text-sm font-semibold text-gray-900">Сервер</th>
          <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900 cursor-pointer" @click="sortBy('price_per_unit')">
            Цена
          </th>
          <th class="px-6 py-3 text-left text-sm font-semibold text-gray-900 cursor-pointer" @click="sortBy('quantity')">
            Доступно
          </th>
          <th class="px-4 py-3 text-left text-sm font-semibold text-gray-900">Продавец</th>
          <th class="px-4 py-3 text-left text-sm font-semibold text-gray-900">Действие</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-gray-200 bg-white">
        <tr v-for="offer in offers" :key="offer.id">
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.title }}</td>
          <td class="px-4 py-3 text-sm text-gray-700">{{ offer.description }}</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.game_name ?? '—' }}</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.server_name ?? '—' }}</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.price_per_unit }} ₽</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.quantity }}</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.user.name }}</td>
          <td class="px-4 py-3 text-sm">
            <button
              @click="buy(offer)"
              class="bg-cyan-600 text-white px-3 py-1 rounded text-sm hover:bg-cyan-700 transition"
            >
              Купить
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<!-- Форма покупки -->
<div v-if="selectedOffer" class="mt-6 max-w-xl mx-auto bg-white border border-gray-200 rounded-xl shadow p-6 space-y-4">
  <div class="flex justify-between items-start">
    <div>
      <h2 class="text-lg font-semibold text-gray-900">Покупка оффера</h2>
      <p class="text-sm text-gray-600 mt-1">Вы выбрали: <span class="font-medium text-gray-800">{{ selectedOffer.title }}</span></p>
    </div>
    <button @click="selectedOffer = null" class="text-gray-400 hover:text-gray-600 text-xl leading-none">&times;</button>
  </div>

  <form @submit.prevent="form.post('/deals', { onSuccess: () => selectedOffer = null })" class="space-y-4">
    <div>
      <label class="block text-sm font-medium text-gray-700">Количество</label>
      <input
        type="number"
        v-model="form.quantity"
        class="mt-1 w-full rounded-md border border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
        min="1"
        :max="selectedOffer.quantity"
      />
      <div v-if="form.errors.quantity" class="text-sm text-red-600 mt-1">{{ form.errors.quantity }}</div>
    </div>
    <div>
  <label class="block text-sm font-medium text-gray-700">Способ оплаты</label>
  <select
    v-model="form.payment_method_id"
    class="mt-1 w-full rounded-md border border-gray-300 shadow-sm focus:ring-cyan-600 focus:border-cyan-600"
  >
    <option value="">Выберите способ</option>
    <option v-for="method in paymentMethods" :key="method.id" :value="method.id">
      {{ method.name }}
    </option>
  </select>
  <div v-if="form.errors.payment_method_id" class="text-sm text-red-600 mt-1">{{ form.errors.payment_method_id }}</div>
</div>
    <div class="flex justify-end space-x-2 pt-2">
      <button
        type="button"
        @click="selectedOffer = null"
        class="text-sm text-gray-600 hover:underline"
      >
        Отмена
      </button>
      <button
        type="submit"
        class="bg-cyan-600 text-white px-4 py-2 rounded-md text-sm hover:bg-cyan-700 transition"
      >
        Подтвердить покупку
      </button>
    </div>
  </form>
</div>
    </div>
  </template>