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
const editGameTypeForm = useForm({ name: '' })
const editingGameTypeId = ref(null)

const categoryForm = useForm({ name: '' })
const editCategoryForm = useForm({ name: '' })
const editingCategoryId = ref(null)

const gameForm = useForm({ name: '', category_id: '', game_type_id: '' })
const editGameForm = useForm({ name: '', category_id: '', game_type_id: '' })
const editingGameId = ref(null)

const serverForm = useForm({ name: '', game_id: '' })
const editServerForm = useForm({ name: '', game_id: '' })
const editingServerId = ref(null)

const paymentForm = useForm({ name: '', details: '' })
const editPaymentForm = useForm({ name: '', details: '' })
const editingPaymentId = ref(null)

const deleteItem = (routeName, id) => {
  if (confirm('Вы уверены, что хотите удалить?')) {
    router.delete(route(routeName, id))
  }
}

const startEditing = (type, item) => {
  if (type === 'category') {
    editingCategoryId.value = item.id
    editCategoryForm.name = item.name
  } else if (type === 'gameType') {
    editingGameTypeId.value = item.id
    editGameTypeForm.name = item.name
  } else if (type === 'game') {
    editingGameId.value = item.id
    editGameForm.name = item.name
    editGameForm.category_id = item.category_id
    editGameForm.game_type_id = item.game_type_id
  } else if (type === 'server') {
    editingServerId.value = item.id
    editServerForm.name = item.name
    editServerForm.game_id = item.game_id
  } else if (type === 'payment') {
    editingPaymentId.value = item.id
    editPaymentForm.name = item.name
    editPaymentForm.details = item.details
  }
}

const updateItem = (type, id) => {
  if (type === 'category') {
    editCategoryForm.put(route('admin.categories.update', id), {
      preserveScroll: true,
      onSuccess: () => (editingCategoryId.value = null)
    })
  } else if (type === 'gameType') {
    editGameTypeForm.put(route('admin.game_types.update', id), {
      preserveScroll: true,
      onSuccess: () => (editingGameTypeId.value = null)
    })
  } else if (type === 'game') {
    editGameForm.put(route('admin.games.update', id), {
      preserveScroll: true,
      onSuccess: () => (editingGameId.value = null)
    })
  } else if (type === 'server') {
    editServerForm.put(route('admin.servers.update', id), {
      preserveScroll: true,
      onSuccess: () => (editingServerId.value = null)
    })
  } else if (type === 'payment') {
    editPaymentForm.put(route('admin.payment_methods.update', id), {
      preserveScroll: true,
      onSuccess: () => (editingPaymentId.value = null)
    })
  }
}
</script>

<template>
  <Head title="Администрирования категории, игр и методов оплаты" />
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
            <td class="p-2">
              <template v-if="editingCategoryId === cat.id">
                <input v-model="editCategoryForm.name" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ cat.name }}
              </template>
            </td>
            <td class="p-2 space-x-2">
              <template v-if="editingCategoryId === cat.id">
                <button @click="updateItem('category', cat.id)" class="text-green-600 hover:underline">Сохранить</button>
                <button @click="editingCategoryId = null" class="text-gray-500 hover:underline">Отмена</button>
              </template>
              <template v-else>
                <button @click="startEditing('category', cat)" class="text-blue-600 hover:underline">Редактировать</button>
                <button @click="deleteItem('admin.categories.destroy', cat.id)" class="text-red-600 hover:underline">Удалить</button>
              </template>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

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
            <td class="p-2">
              <template v-if="editingGameTypeId === type.id">
                <input v-model="editGameTypeForm.name" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ type.name }}
              </template>
            </td>
            <td class="p-2 space-x-2">
              <template v-if="editingGameTypeId === type.id">
                <button @click="updateItem('gameType', type.id)" class="text-green-600 hover:underline">Сохранить</button>
                <button @click="editingGameTypeId = null" class="text-gray-500 hover:underline">Отмена</button>
              </template>
              <template v-else>
                <button @click="startEditing('gameType', type)" class="text-blue-600 hover:underline">Редактировать</button>
                <button @click="deleteItem('admin.game_types.destroy', type.id)" class="text-red-600 hover:underline">Удалить</button>
              </template>
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
            <th class="p-2 text-left">Категория</th>
            <th class="p-2 text-left">Действия</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="game in games" :key="game.id" class="border-t">
            <td class="p-2">{{ game.id }}</td>
            <td class="p-2">
              <template v-if="editingGameId === game.id">
                <input v-model="editGameForm.name" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ game.name }}
              </template>
            </td>
            <td class="p-2">
              <template v-if="editingGameId === game.id">
                <select v-model="editGameForm.category_id" class="border rounded px-2 py-1">
                  <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                </select>
              </template>
              <template v-else>
                {{ game.category?.name ?? '—' }}
              </template>
            </td>
            <td class="p-2 space-x-2">
              <template v-if="editingGameId === game.id">
                <button @click="updateItem('game', game.id)" class="text-green-600 hover:underline">Сохранить</button>
                <button @click="editingGameId = null" class="text-gray-500 hover:underline">Отмена</button>
              </template>
              <template v-else>
                <button @click="startEditing('game', game)" class="text-blue-600 hover:underline">Редактировать</button>
                <button @click="deleteItem('admin.games.destroy', game.id)" class="text-red-600 hover:underline">Удалить</button>
              </template>
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
            <td class="p-2">
              <template v-if="editingServerId === srv.id">
                <input v-model="editServerForm.name" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ srv.name }}
              </template>
            </td>
            <td class="p-2">
              <template v-if="editingServerId === srv.id">
                <select v-model="editServerForm.game_id" class="border rounded px-2 py-1">
                  <option v-for="game in games" :key="game.id" :value="game.id">{{ game.name }}</option>
                </select>
              </template>
              <template v-else>
                {{ srv.game?.name ?? '—' }}
              </template>
            </td>
            <td class="p-2 space-x-2">
              <template v-if="editingServerId === srv.id">
                <button @click="updateItem('server', srv.id)" class="text-green-600 hover:underline">Сохранить</button>
                <button @click="editingServerId = null" class="text-gray-500 hover:underline">Отмена</button>
              </template>
              <template v-else>
                <button @click="startEditing('server', srv)" class="text-blue-600 hover:underline">Редактировать</button>
                <button @click="deleteItem('admin.servers.destroy', srv.id)" class="text-red-600 hover:underline">Удалить</button>
              </template>
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
            <td class="p-2">
              <template v-if="editingPaymentId === pm.id">
                <input v-model="editPaymentForm.name" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ pm.name }}
              </template>
            </td>
            <td class="p-2">
              <template v-if="editingPaymentId === pm.id">
                <input v-model="editPaymentForm.details" class="border rounded px-2 py-1 w-full" />
              </template>
              <template v-else>
                {{ pm.details ?? '—' }}
              </template>
            </td>
            <td class="p-2 space-x-2">
              <template v-if="editingPaymentId === pm.id">
                <button @click="updateItem('payment', pm.id)" class="text-green-600 hover:underline">Сохранить</button>
                <button @click="editingPaymentId = null" class="text-gray-500 hover:underline">Отмена</button>
              </template>
              <template v-else>
                <button @click="startEditing('payment', pm)" class="text-blue-600 hover:underline">Редактировать</button>
                <button @click="deleteItem('admin.payment_methods.destroy', pm.id)" class="text-red-600 hover:underline">Удалить</button>
              </template>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
