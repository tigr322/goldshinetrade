<script setup>
import { ref } from 'vue'
import { router, usePage } from '@inertiajs/vue3'
import { Link } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
const props = defineProps({
  users: Array
})

const updateRole = (userId, role) => {
  router.patch(`/admin/users/${userId}/role`, { role })
}
</script>

<template>
    <div class="max-w-7xl mx-auto py-10">
      <h1 class="text-2xl font-bold text-gray-900 mb-6">Управление пользователями</h1>
  
      <!-- Контейнер прокрутки -->
      <div class="overflow-x-auto w-full">
        <table class="min-w-full bg-white shadow rounded-xl overflow-hidden">
          <thead class="bg-gray-100 text-left text-sm font-semibold text-gray-700">
            <tr>
              <th class="p-4 whitespace-nowrap">Имя</th>
              <th class="p-4 whitespace-nowrap">Email</th>
              <th class="p-4 whitespace-nowrap">Роль</th>
              <th class="p-4 whitespace-nowrap">Действия</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="user in users" :key="user.id" class="border-t">
              <td class="p-4 whitespace-nowrap">{{ user.name }}</td>
              <td class="p-4 whitespace-nowrap">{{ user.email }}</td>
              <td class="p-4 whitespace-nowrap">
                {{ user.roles[0]?.name || 'Нет роли' }}
              </td>
              <td class="p-4 whitespace-nowrap">
                <select @change="e => updateRole(user.id, e.target.value)" class="border rounded p-1">
                  <option disabled selected>Изменить роль</option>
                  <option value="admin">Админ</option>
                  <option value="moderator">Модератор</option>
                  <option value="user">Пользователь</option>
                </select>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </template>