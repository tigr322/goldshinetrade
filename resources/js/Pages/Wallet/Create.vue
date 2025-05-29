<script setup>
import { useForm } from '@inertiajs/vue3'
import { computed } from 'vue'

const props = defineProps({
  cards: Array,
})

const form = useForm({
  amount: '',
  card_id: '', // выбранная карта
})

// Подсказка: выбираем основную карту по умолчанию
const defaultCard = computed(() => props.cards.find(c => c.primary))
if (defaultCard.value) {
  form.card_id = defaultCard.value.id
}
</script>

<template>
    <Head title="Кошелек" />
  <div class="max-w-md mx-auto bg-white p-6 rounded shadow">
    <h2 class="text-xl font-bold mb-4">Пополнение кошелька</h2>
    
    <form @submit.prevent="form.post('/wallet/topup')">
      <!-- Выбор карты -->
      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-1">Выберите карту</label>
        <select
          v-model="form.card_id"
          class="block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-500 focus:border-cyan-500"
        >
          <option disabled value="">Выберите карту</option>
          <option v-for="card in props.cards" :key="card.id" :value="card.id">
            {{ card.name }} — {{ card.type }} •••• {{ card.number }}
          </option>
        </select>
      </div>

      <!-- Сумма -->
      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700">Сумма (₽)</label>
        <input
          type="number"
          v-model="form.amount"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-cyan-500 focus:border-cyan-500"
        />
      </div>

      <button
        type="submit"
        class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700"
      >
        Пополнить
      </button>
    </form>
  </div>
</template>