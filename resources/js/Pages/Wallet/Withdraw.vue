<script setup>
import { useForm } from '@inertiajs/vue3'
import { computed } from 'vue'
import AppLayout from '@/Layouts/AppLayout.vue'

const props = defineProps({
  cards: Array,
})
const form = useForm({
  amount: '',
  card_id: '', // выбранная карта
})
const defaultCard = computed(() => props.cards.find(c => c.primary))
if (defaultCard.value) {
  form.card_id = defaultCard.value.id
}
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
</script>
<template>
    <div class="p-4">
        <h1 class="text-2xl font-bold mb-4">Вывод средств</h1>
        <form @submit.prevent="form.post('/wallet/withdraw')">

            <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700">Сумма (₽)</label>
        <input
          type="number"
          v-model="form.amount"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-500 focus:border-cyan-500"
        />
      </div>
      <div
        v-for="card in props.cards"
        :key="card.id"
        class="relative rounded-lg border border-gray-300 bg-white px-6 py-5 shadow-sm flex items-center space-x-3 hover:border-gray-400 focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-cyan-500"
      >
        <div class="flex-shrink-0">
          <div class="h-10 w-10 rounded-full bg-cyan-600 flex items-center justify-center">
            <CreditCardIcon class="h-6 w-6 text-white" />
          </div>
        </div>
        <div class="flex-1 min-w-0">
          <div class="flex justify-between">
           
            <p class="text-sm font-medium text-gray-900">{{ card.name }}</p>
            <span
              v-if="card.primary"
              class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-cyan-100 text-cyan-800"
            >
              Основная
            </span>
          </div>
          <p class="text-sm text-gray-500 truncate">{{ card.type }} •••• {{ card.number }}</p>
          <p class="text-sm text-gray-500">Действует до {{ card.expiry }}</p>
        </div>
        <div class="flex space-x-2">
          <input
            type="radio"
            :value="card.id"
            v-model="form.card_id"
            class="h-4 w-4 text-cyan-600 border-gray-300 focus:ring-cyan-500"
          />
        </div>
      </div>
      <button
        type="submit"
        class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700"
      >
        Вывод
      </button>
        </form>
    </div>
</template>