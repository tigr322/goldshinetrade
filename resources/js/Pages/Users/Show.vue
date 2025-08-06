<script setup>
import AppLayout from '@/Layouts/AppLayout.vue'
import { Head } from '@inertiajs/vue3'

const props = defineProps({
  user: Object,
  offers: Array,
  reviews: Array
})
</script>

<template>
  <Head :title="`Профиль ${user.name}`" />
  <AppLayout>
    <div class="max-w-5xl mx-auto px-4 py-8">
      <div class="bg-white shadow rounded-lg p-6">
        <div class="flex items-center gap-4">
          <img
         
            :src="`/storage/${user.photo}`"
            class="w-16 h-16 rounded-full object-cover border"
            alt="Аватар"
          />
          <div>
            <h1 class="text-2xl font-semibold">{{ user.name }}</h1>
            <p class="text-gray-500 text-sm">{{ user.adress }}</p>
            <p class="text-gray-600 text-sm">Рейтинг: <strong>{{ user.rating ?? '—' }}</strong></p>
          </div>
        </div>
      </div>

      <!-- Офферы -->
      <div class="mt-8">
        <h2 class="text-xl font-bold mb-3">Офферы</h2>
        <div v-if="offers.length" class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div v-for="offer in offers" :key="offer.id" class="bg-white shadow p-4 rounded-lg border">
            <h3 class="font-semibold text-lg">{{ offer.title }}</h3>
            <p class="text-sm text-gray-600">{{ offer.description }}</p>
            <p class="mt-2 font-medium text-cyan-700">Цена: {{ offer.price }} ₽</p>
          </div>
        </div>
        <p v-else class="text-gray-500">Нет опубликованных офферов</p>
      </div>

      <!-- Отзывы -->
      <div class="mt-10">
        <h2 class="text-xl font-bold mb-3">Отзывы</h2>
        <div v-if="reviews.length" class="space-y-4">
          <div
            v-for="review in reviews"
            :key="review.id"
            class="bg-white p-4 rounded-lg shadow border"
          >
            <div class="flex justify-between items-center">
              <span class="text-gray-700 font-medium">
                От: {{ review.from_user?.name ?? 'Аноним' }}
              </span>
              <span class="text-yellow-500 font-semibold text-sm">
                ★ {{ review.rating }}/5
              </span>
            </div>
            <p class="mt-2 text-gray-600">{{ review.comment }}</p>
          </div>
        </div>
        <p v-else class="text-gray-500">Нет отзывов</p>
      </div>
    </div>
  </AppLayout>
</template>
