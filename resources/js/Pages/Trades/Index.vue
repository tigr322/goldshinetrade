<script setup>
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({
  offers: Array,
  currencies: Array
})

const selectedOffer = ref(null)

// форма покупки
const form = useForm({
  offer_id: '',
  quantity: 1,
})

const buy = (offer) => {
  selectedOffer.value = offer
  form.offer_id = offer.id
  form.quantity = 1
}

// форма создания оффера
const createForm = useForm({
  title: '',
  description: '',
  price_per_unit: '',
  quantity: '',
  currency_id: '',
})
</script>

<template>
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

    <!-- Таблица офферов -->
   <!-- Список офферов в стиле списка с иконками -->
<div class="shadow sm:hidden">
  <ul role="list" class="mt-2 divide-y divide-gray-200 overflow-hidden shadow sm:hidden">
    <li v-for="offer in offers" :key="offer.id">
      <div class="block bg-white px-4 py-4 hover:bg-gray-50">
        <div class="flex items-center space-x-4">
          <div class="flex flex-1 space-x-2 truncate">
            <BanknotesIcon class="h-5 w-5 flex-shrink-0 text-gray-400" aria-hidden="true" />
            <div class="flex flex-col truncate text-sm text-gray-500">
              <span class="truncate font-medium text-gray-900">{{ offer.title }}</span>
              <span>
                Цена: <span class="font-medium text-gray-900">{{ offer.price_per_unit }}</span> {{ offer.currency.name }}
              </span>
              <span>
                Кол-во: {{ offer.quantity }}
              </span>
              <span>
                Продавец: {{ offer.user.name }}
              </span>
            </div>
          </div>
          <button @click="buy(offer)" class=" bg-cyan-600 text-white px-3 py-1 rounded text-sm">Купить</button>
        </div>
      </div>
    </li>
  </ul>
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
