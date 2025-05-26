<script setup>
import { useForm, router } from '@inertiajs/vue3'
import { ref } from 'vue'
import AppLayout from '@/Layouts/AppLayout.vue'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
const props = defineProps({
  categories: Array,
  games: Array,
  servers: Array,
  paymentMethods: Array,
  gameTypes: Array 
})
const gameTypeForm = useForm({ name: '' })
const categoryForm = useForm({ name: '' })
const gameForm = useForm({ name: '', category_id: '', game_type_id: '' })
const serverForm = useForm({ name: '', game_id: '' })
const paymentForm = useForm({ name: '', details: '' })

const deleteItem = (routeName, id) => {
  if (confirm('Вы уверены, что хотите удалить?')) {
    router.delete(route(routeName, id))
  }
}
</script>

<template>
  <div class="max-w-7xl mx-auto py-10 space-y-12">
    <!-- Категории -->
    <div class="bg-white shadow rounded-xl p-6">
      <h2 class="text-lg font-semibold text-gray-900">Категории</h2>
      <form @submit.prevent="categoryForm.post(route('admin.categories.store'))" class="flex gap-2 mt-4">
        <input v-model="categoryForm.name" type="text" placeholder="Название категории" class="border rounded p-2 w-full" />
        <button type="submit" class="bg-cyan-600 text-white px-4 rounded">Добавить</button>
      </form>
      <table class="w-full mt-6 text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2 text-left">ID</th>
            <th class="p-2 text-left">Название</th>
            <th class="p-2 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="cat in categories" :key="cat.id" class="border-t">
            <td class="p-2">{{ cat.id }}</td>
            <td class="p-2">{{ cat.name }}</td>
            <td class="p-2">
              <button @click="deleteItem('admin.categories.destroy', cat.id)" class="text-red-600 hover:underline">Удалить</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- Типы игр -->
<div class="bg-white shadow rounded-xl p-6">
  <h2 class="text-lg font-semibold text-gray-900">Типы игр</h2>
  <form @submit.prevent="gameTypeForm.post(route('admin.game_types.store'))" class="flex gap-2 mt-4">
    <input v-model="gameTypeForm.name" type="text" placeholder="Название типа игры" class="border rounded p-2 w-full" />
    <button type="submit" class="bg-cyan-600 text-white px-4 rounded">Добавить</button>
  </form>
  <table class="w-full mt-6 text-sm">
    <thead class="bg-gray-100">
      <tr>
        <th class="p-2 text-left">ID</th>
        <th class="p-2 text-left">Название</th>
        <th class="p-2 text-left">Действия</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="type in gameTypes" :key="type.id" class="border-t">
        <td class="p-2">{{ type.id }}</td>
        <td class="p-2">{{ type.name }}</td>
        <td class="p-2">
          <button @click="deleteItem('admin.game_types.destroy', type.id)" class="text-red-600 hover:underline">Удалить</button>
        </td>
      </tr>
    </tbody>
  </table>
</div>
    <!-- Игры -->
    <div class="bg-white shadow rounded-xl p-6">
      <h2 class="text-lg font-semibold text-gray-900">Игры</h2>
      <form @submit.prevent="gameForm.post(route('admin.games.store'))" class="grid grid-cols-1 md:grid-cols-3 gap-2 mt-4">
        <input v-model="gameForm.name" type="text" placeholder="Название" class="border rounded p-2" />
        <select v-model="gameForm.category_id" class="border rounded p-2">
          <option disabled selected>Выберите категорию</option>
          <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
        </select>
        <select v-model="gameForm.game_type_id" class="border rounded p-2">
  <option disabled selected value="">Выберите тип</option>
  <option v-for="type in gameTypes" :key="type.id" :value="type.id">{{ type.name }}</option>
</select>        <div class="col-span-full">
          <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded">Добавить</button>
        </div>
      </form>
      <table class="w-full mt-6 text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2 text-left">ID</th>
            <th class="p-2 text-left">Название</th>
            <th class="p-2 text-left">Категория</th>
            <th class="p-2 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="game in games" :key="game.id" class="border-t">
            <td class="p-2">{{ game.id }}</td>
            <td class="p-2">{{ game.name }}</td>
            <td class="p-2">{{ game.category?.name ?? '—' }}</td>
            <td class="p-2">
              <button @click="deleteItem('admin.games.destroy', game.id)" class="text-red-600 hover:underline">Удалить</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Серверы -->
    <div class="bg-white shadow rounded-xl p-6">
      <h2 class="text-lg font-semibold text-gray-900">Серверы</h2>
      <form @submit.prevent="serverForm.post(route('admin.servers.store'))" class="grid grid-cols-1 md:grid-cols-2 gap-2 mt-4">
        <input v-model="serverForm.name" type="text" placeholder="Название сервера" class="border rounded p-2" />
        <select v-model="serverForm.game_id" class="border rounded p-2">
          <option disabled selected>Выберите игру</option>
          <option v-for="game in games" :key="game.id" :value="game.id">{{ game.name }}</option>
        </select>
        <div class="col-span-full">
          <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded">Добавить</button>
        </div>
      </form>
      <table class="w-full mt-6 text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2 text-left">ID</th>
            <th class="p-2 text-left">Название</th>
            <th class="p-2 text-left">Игра</th>
            <th class="p-2 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="srv in servers" :key="srv.id" class="border-t">
            <td class="p-2">{{ srv.id }}</td>
            <td class="p-2">{{ srv.name }}</td>
            <td class="p-2">{{ srv.game?.name ?? '—' }}</td>
            <td class="p-2">
              <button @click="deleteItem('admin.servers.destroy', srv.id)" class="text-red-600 hover:underline">Удалить</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Методы оплаты -->
    <div class="bg-white shadow rounded-xl p-6">
      <h2 class="text-lg font-semibold text-gray-900">Методы оплаты</h2>
      <form @submit.prevent="paymentForm.post(route('admin.payment_methods.store'))" class="grid grid-cols-1 md:grid-cols-2 gap-2 mt-4">
        <input v-model="paymentForm.name" type="text" placeholder="Название метода" class="border rounded p-2" />
        <input v-model="paymentForm.details" type="text" placeholder="Доп. детали (необязательно)" class="border rounded p-2" />
        <div class="col-span-full">
          <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded">Добавить</button>
        </div>
      </form>
      <table class="w-full mt-6 text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2 text-left">ID</th>
            <th class="p-2 text-left">Название</th>
            <th class="p-2 text-left">Детали</th>
            <th class="p-2 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="pm in paymentMethods" :key="pm.id" class="border-t">
            <td class="p-2">{{ pm.id }}</td>
            <td class="p-2">{{ pm.name }}</td>
            <td class="p-2">{{ pm.details ?? '—' }}</td>
            <td class="p-2">
              <button @click="deleteItem('admin.payment_methods.destroy', pm.id)" class="text-red-600 hover:underline">Удалить</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>