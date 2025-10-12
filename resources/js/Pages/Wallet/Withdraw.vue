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

      <button
        type="submit"
        class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700"
      >
        Вывод
      </button>
        </form>
    </div>
</template>