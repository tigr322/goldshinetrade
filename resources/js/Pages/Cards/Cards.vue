<script setup>
import { router } from '@inertiajs/vue3'
import { CreditCardIcon, TrashIcon } from '@heroicons/vue/24/outline'
import AppLayout from '@/Layouts/AppLayout.vue'
import { Link } from '@inertiajs/vue3'

const props = defineProps({
  cards: Array
})

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const deleteCard = (id) => {
  console.log('Удаление карты:', id) // ← прspanоверка
  if (confirm('Вы уверены, что хотите удалить эту карту?')) {
    router.delete(route('cards.destroy', id))
  }
}
</script>

<template>
    <Head title="Карты" />
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <h2 class="text-lg font-medium leading-6 text-gray-900">Мои карты</h2>
      <Link
        href="/cards/add"
        class="inline-flex items-center rounded-md border border-transparent bg-cyan-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
      >
        Добавить карту
      </Link>
    </div>

    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
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
          <button
            @click="deleteCard(card.id)"
            class="text-red-600 hover:text-red-900"
            title="Удалить карту"
          >
            <TrashIcon class="h-5 w-5" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>