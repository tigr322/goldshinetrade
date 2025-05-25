<script setup>
import { Link, router } from '@inertiajs/vue3'
defineProps({ offers: Object })

const destroy = (id) => {
  if (confirm('Удалить оффер?')) {
    router.delete(route('admin.offers.destroy', id))
  }
}
</script>

<template>
  <div class="max-w-7xl mx-auto py-10">
    <h1 class="text-2xl font-bold text-cyan-700 mb-6">Все офферы</h1>

    <div class="bg-white shadow overflow-hidden rounded-xl">
      <table class="w-full text-sm">
        <thead class="bg-gray-100 text-gray-700 font-semibold">
          <tr>
            <th class="p-3 text-left">ID</th>
            <th class="p-3 text-left">Заголовок</th>
            <th class="p-3 text-left">Цена</th>
            <th class="p-3 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="offer in offers.data" :key="offer.id" class="border-t">
            <td class="p-3">{{ offer.id }}</td>
            <td class="p-3">{{ offer.title }}</td>
            <td class="p-3">{{ offer.price }} ₽</td>
            <td class="p-3 space-x-2">
              <Link :href="route('admin.offers.edit', offer.id)" class="text-blue-600 hover:underline">Редактировать</Link>
              <button @click="destroy(offer.id)" class="text-red-600 hover:underline">Удалить</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>