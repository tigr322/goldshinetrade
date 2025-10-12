<script setup>
import { useForm } from '@inertiajs/vue3'
import { computed, watch } from 'vue'
import AppLayout from '@/Layouts/AppLayout.vue'

const props = defineProps({
  cards: { type: Array, default: () => [] },
})

const form = useForm({
  amount: '',
  card_id: null, // пусть будет числом
})

const defaultCard = computed(() => props.cards.find(c => c.primary))

// Реактивно проставляем карту по умолчанию, когда приедут пропсы
watch(defaultCard, (val) => {
  if (val && (form.card_id === null || form.card_id === '')) {
    form.card_id = val.id
  }
}, { immediate: true })

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
          v-model.number="form.amount"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-500 focus:border-cyan-500"
          min="1"
        />
      </div>

      <div
        v-for="card in props.cards"
        :key="card.id"
        class="relative rounded-lg border border-gray-300 bg-white px-6 py-5 shadow-sm flex items-center space-x-3 hover:border-gray-400 focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-cyan-500"
      >
        <div class="flex-1 min-w-0">
          <div class="flex justify-between">
            <p class="text-sm font-medium text-gray-900">{{ card.name }}</p>
            <span v-if="card.primary" class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-cyan-100 text-cyan-800">
              Основная
            </span>
          </div>
          <p class="text-sm text-gray-500 truncate">{{ card.type }} •••• {{ card.number }}</p>
          <p class="text-sm text-gray-500">Действует до {{ card.expiry }}</p>
        </div>

        <input
          type="radio"
          name="card_id"               
          :value="card.id"              
          v-model.number="form.card_id" 
          class="h-4 w-4 text-cyan-600 border-gray-300 focus:ring-cyan-500"
        />
      </div>

      <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
        Вывод
      </button>
    </form>
  </div>
</template>
