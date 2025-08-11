<script setup>
import { ref, computed, watch } from 'vue'
import { useForm, router } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
import { usePage } from '@inertiajs/vue3'

const flash = computed(() => {
  const props = usePage().props
  return props && props.flash ? props.flash : {}
})

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const user = usePage().props.auth.user

const props = defineProps({
  offers: Array,
  categories: Array,
  gameTypes: Array,
  games: Array,
  servers: Array,
  filters: Object,
  paymentMethods: Array,
  fees: Object,
})

const showCreateModal = ref(false)
const availableServers = ref([])

const filters = ref({
  game_name: '',
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
  full_description: '',
  category_id: '',
  game_type_id: '',
  game_id: '',
  server_id: '',
  price: '',
  quantity: '',
})

// === добавлено: расчёт «продавец получит» ===

// ===========================================

watch(() => createForm.category_id, () => {
  createForm.game_id = ''
  createForm.server_id = ''
  createForm.game_type_id = ''
})

const uniqueGames = computed(() => {
  const set = new Set()
  props.offers.forEach(o => o.game_name && set.add(o.game_name))
  return [...set]
})

const availableGames = computed(() => {
  if (!createForm.category_id) return []
  return props.games.filter(g => g.category_id == createForm.category_id)
})

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
    const matchCategory = !filters.value.category_id || offer.category_id == filters.value.category_id
    const matchGame = !filters.value.game_name || offer.game_name === filters.value.game_name
    const matchSearch = !filters.value.search || offer.title.toLowerCase().includes(filters.value.search.toLowerCase())
    return matchCategory && matchGame && matchSearch
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
const feeModel = computed(() => props.fees?.model ?? 'buyer_pays')

const buyerPercent = computed(() => {
  if (feeModel.value === 'split') return props.fees?.split?.buyer_percent ?? 0
  if (feeModel.value === 'buyer_pays') return props.fees?.buyer_percent ?? 0
  return 0 // seller_pays — покупатель платит ровно price
})

const sellerPercent = computed(() => {
  if (feeModel.value === 'split') return props.fees?.split?.seller_percent ?? 0
  if (feeModel.value === 'seller_pays') return props.fees?.seller_percent ?? 0
  return 0 // buyer_pays — продавцу без удержаний
})

// «продавец получит»
const sellerReceive = computed(() => {
  const price = Number(createForm.price) || 0
  const pct = Number(sellerPercent.value) || 0
  return (price * (1 - pct / 100)).toFixed(2)
})

// «покупатель заплатит»
const buyerPriceCreate = computed(() => {
  const price = Number(createForm.price) || 0
  const pct = Number(buyerPercent.value) || 0
  return (price * (1 + pct / 100)).toFixed(2)
})

const buyerPriceForOffer = (offer) => {
  const model = offer.fee_model ?? props.fees?.model ?? 'buyer_pays'

  // процент для покупателя
  const pct = model === 'split'
    ? (offer.fee_buyer_percent ?? props.fees?.split?.buyer_percent ?? 0)
    : (model === 'buyer_pays'
        ? (offer.fee_buyer_percent ?? props.fees?.buyer_percent ?? 0)
        : 0) // seller_pays

  const price = Number(offer.price_per_unit ?? offer.price ?? 0)
  return (price * (1 + pct / 100)).toFixed(2)
}

</script>

<template>
     <Head title="Офферы" />
        
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
            <div>
              <label class="block text-sm font-medium text-gray-700">Полное описание</label>
              <textarea v-model="createForm.full_description" rows="3" class="w-full border rounded-md shadow-sm" />
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
              <input v-model.number="createForm.price" type="number" step="0.01" class="w-full border rounded-md shadow-sm" />

              <!-- Мини-текст под ценой -->
              <p class="text-xs text-gray-500 mt-1">
                Продавец получит: <span class="font-semibold text-gray-900">{{ sellerReceive }} ₽</span>
              </p>
              <p class="text-xs text-gray-500 mt-1">
                Покупатель заплатит:
                <span class="font-semibold text-gray-900">{{ buyerPriceCreate }} ₽</span>
                <span v-if="buyerPercent"
                      class="ml-1 inline-block rounded bg-cyan-50 px-1.5 py-0.5 text-[11px] text-cyan-700">
                  +{{ buyerPercent }}%
                </span>
              </p>


            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Количество</label>
              <input v-model.number="createForm.quantity" type="number" class="w-full border rounded-md shadow-sm" />
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
      <div v-if="flash.success" class="mb-4 p-4 rounded bg-green-100 text-green-800 border border-green-200">
  {{ flash.success }}
</div>

<div v-if="flash.error" class="mb-4 p-4 rounded bg-red-100 text-red-800 border border-red-200">
  {{ flash.error }}
</div>
<div class="mb-6 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
  <!-- Фильтр по названию игры -->
  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1">Игра</label>
    <select v-model="filters.game_name" @change="submitFilter" class="w-full border rounded-md shadow-sm">
      <option value="">Все</option>
      <option v-for="name in uniqueGames" :key="name" :value="name">{{ name }}</option>
    </select>
  </div>

  <!-- Фильтр по категории -->
  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1">Категория</label>
    <select v-model="filters.category_id" @change="submitFilter" class="w-full border rounded-md shadow-sm">
      <option value="">Все</option>
      <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
    </select>
  </div>

  <!-- Поиск -->
  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1">Поиск</label>
    <input type="text" v-model="filters.search" @input="submitFilter"
           class="w-full border rounded-md shadow-sm" placeholder="По названию оффера..." />
  </div>
</div>
   <!-- Контейнер с горизонтальной прокруткой только на мобильных -->
<div class="mx-auto mt-10">
  <div class="sm:overflow-visible overflow-x-auto">
    <div class="inline-block min-w-full align-middle">
      <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
        <table class="w-full min-w-[700px] divide-y divide-gray-300 table-fixed">
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
          <td class="px-4 py-3 text-sm text-gray-900">{{ (offer.price_per_unit ?? offer.price).toFixed ? (offer.price_per_unit ?? offer.price).toFixed(2) : (offer.price_per_unit ?? offer.price) }} ₽</td>
          <td class="px-4 py-3 text-sm text-gray-900">{{ offer.quantity }}</td>
          <td class="px-4 py-3 text-sm text-gray-900"> 
      <a
        :href="route('users.show', { user: offer.user.id })"
        class="text-blue-600 hover:underline"
      >
      <img
         
         :src="`/storage/${offer.user.photo ?? 'default.png'}`"
         class="w-8 h-8 rounded-full object-cover border"
         alt="Аватар"
       />
        {{ offer.user.name }}
      </a>
   </td>
          <td class="px-4 py-3 text-sm">
  <button
    v-if="offer.user.id !== user.id"
    @click="buy(offer)"
    class="bg-cyan-600 text-white px-3 py-1 rounded text-sm hover:bg-cyan-700 transition"
  >
    Купить
  </button>
  <span v-else class="text-gray-400 text-xs">Ваш оффер</span>
</td>
        </tr>
      </tbody>
    </table>
      </div>
    </div>
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

  <form @submit.prevent="form.post('/deals', {
  onSuccess: (page) => {
    const dealId = page.props?.deal?.id // предполагается, что контроллер возвращает ID сделки
    if (dealId) {
      selectedOffer.value = null
      router.visit(`/deals/${dealId}`)
    }
  },
})" class="space-y-4">
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
  
  </template>