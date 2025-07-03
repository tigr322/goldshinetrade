<script setup>
import { ref, onMounted } from 'vue'
import { usePage } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
import Echo from '@/echo' // ✅ Echo instance
import axios from 'axios'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({ deal: Object })
const user = usePage().props.auth.user

const messages = ref([])
const newMessage = ref('')

// ✅ Загрузка сообщений
const loadMessages = async () => {
  const res = await axios.get(route('messages.index', props.deal.id))
  messages.value = res.data.reverse()
}

// ✅ Отправка
const sendMessage = async () => {
  if (!newMessage.value.trim()) return
  await axios.post(route('messages.store', props.deal.id), {
    content: newMessage.value,
  })
  newMessage.value = ''
}

// ✅ Подключение к каналу и приём события
onMounted(async () => {

  Echo.connector.pusher.connection.bind('connected', () => {
    console.log('✅ Подключено к Pusher')
  })

  Echo.private(`deal.${props.deal.id}`)
    .listen('.App\\Events\\NewMessageSent', (e) => {
        console.log('📨 Новое сообщение:', e)
        messages.value.push({
            id: e.id,
            content: e.content,
            user: e.user,
            created_at: e.created_at,
        })
    })
  loadMessages()
})
</script>

<template>
  <Head title="Сделка" />

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
      <h2 class="font-semibold text-lg">Чат с продавцом</h2>
      <div class="border rounded p-4 bg-white max-h-96 overflow-y-auto space-y-2">
        <div v-for="m in messages" :key="m.id" class="text-sm">
          <span class="font-semibold">{{ m.user.name }}:</span>
          <span>{{ m.content }}</span>
          <span class="text-xs text-gray-400 ml-2">
            {{ new Date(m.created_at).toLocaleTimeString() }}
          </span>
        </div>
      </div>
      <form @submit.prevent="sendMessage" class="flex gap-2 mt-4">
        <input
          v-model="newMessage"
          type="text"
          placeholder="Сообщение..."
          class="flex-1 border rounded px-4 py-2"
        />
        <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
          Отправить
        </button>
      </form>
    </div>
  </div>
</template>