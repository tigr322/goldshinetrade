<script setup>
import { useForm } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({ deal: Object })

const form = useForm({})
const confirmDeal = () => {
  form.post(route('deals.confirm', props.deal.id))
}
</script>

<template>
  <div class="max-w-4xl mx-auto mt-8 space-y-6">
    <h1 class="text-2xl font-bold text-gray-800">Сделка #{{ deal.id }}</h1>
    <p>Продавец: {{ deal.offer.user.name }}</p>
    <p>Сумма: {{ deal.total_price }} ₽</p>
    <p>Статус: {{ deal.status }}</p>

    <div v-if="deal.status === 'paid'">
      <button @click="confirmDeal" class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
        Подтвердить получение
      </button>
    </div>

    <div class="mt-6">
      <!-- Заглушка под чат -->
      <h2 class="font-semibold text-lg">Чат с продавцом</h2>
      <div class="border rounded p-4 bg-white">[чат будет тут]</div>
    </div>
  </div>
</template>