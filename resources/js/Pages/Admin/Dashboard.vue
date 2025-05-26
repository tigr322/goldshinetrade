<script setup>
import AppLayout from '@/Layouts/AppLayout.vue'
import { Link } from '@inertiajs/vue3'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
</script>

<template>
  <div class="max-w-7xl mx-auto py-10">
    <h1 class="text-2xl font-bold text-gray-900 mb-6">Админ-панель</h1>
    
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div class="bg-white shadow rounded-xl p-6">
        <h2 class="text-lg font-semibold text-gray-900">Пользователи</h2>
        <p class="text-sm text-gray-500 mt-2">Управление пользователями</p>
        <Link :href="route('admin.users.index')" class="mt-4 inline-block text-cyan-600 hover:underline">Перейти</Link>     </div>

      <div class="bg-white shadow rounded-xl p-6">
        <h2 class="text-lg font-semibold text-gray-900">Офферы</h2>
        <p class="text-sm text-gray-500 mt-2">Просмотр всех объявлений</p>
        <Link :href="route('admin.offers.index')" class="mt-4 inline-block text-cyan-600 hover:underline">Перейти</Link>      </div>

        <div class="bg-white shadow rounded-xl p-6">
        <h2 class="text-lg font-semibold text-gray-900">Категории, игровые категории, сервера, методы оплаты</h2>
        <p class="text-sm text-gray-500 mt-2">Просмотр всей информации о сайта</p>
        <Link :href="route('admin.data.index')" class="mt-4 inline-block text-cyan-600 hover:underline">Перейти</Link>      </div>

      <div class="bg-white shadow rounded-xl p-6">
        <h2 class="text-lg font-semibold text-gray-900">Жалобы</h2>
        <p class="text-sm text-gray-500 mt-2">Обработка жалоб пользователей</p>
        <Link href="#" class="mt-4 inline-block text-cyan-600">Перейти</Link>
      </div>
    </div>
  </div>
</template>