<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { usePage } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
import Echo from '@/echo'
import axios from 'axios'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({ deal: Object })
const user = usePage().props.auth.user

const messages = ref([])
const newMessage = ref('')

// === [НОВОЕ] аватар-хелперы ===
const defaultAvatar = '/storage/default.png'
const avatarUrl = (u) => {
  if (!u) return defaultAvatar
  // если backend позже добавит миниатюры (photo_thumb) — просто подменишь тут на u.photo_thumb
  const p = u.photo
  return p ? `/storage/${p}` : defaultAvatar
}
const onImgErr = (e) => { e.target.src = defaultAvatar }

// === остальной код как был ===
const markMessagesAsRead = async () => {
  const unreadIds = messages.value
    .filter(msg => msg.user?.id !== user.id && !msg.read_by_me && typeof msg.id === 'number')
    .map(msg => msg.id)

  if (unreadIds.length > 0) {
    try {
      await axios.post(route('messages.markRead'), { message_ids: unreadIds })
      messages.value.forEach(msg => {
        if (unreadIds.includes(msg.id)) msg.read_by_me = true
      })
    } catch (err) {
      console.warn('Ошибка при отметке сообщений как прочитанных:', err)
    }
  }
}

const loadMessages = async () => {
  const res = await axios.get(route('messages.index', props.deal.id))
  messages.value = res.data.reverse()

  const storageKey = `goldshinetrade_conf_notice_${props.deal.id}`
  let systemMessage = null

  const cached = localStorage.getItem(storageKey)
  if (cached) {
    try { systemMessage = JSON.parse(cached) } catch {}
  } else {
    systemMessage = {
      id: 'warning',
      user: { name: 'Система' },
      content: '⚠️ Никогда не отправляйте предоплату до получения товара. Все сообщения сохраняются. В случае подозрительной активности сообщите в поддержку.',
      created_at: new Date().toISOString(),
    }
    localStorage.setItem(storageKey, JSON.stringify(systemMessage))
  }

  if (systemMessage) {
    messages.value.push(systemMessage)
    messages.value.sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
  }

  await nextTick()
  markMessagesAsRead()
}

const sendMessage = async () => {
  if (!newMessage.value.trim()) return
  await axios.post(route('messages.store', props.deal.id), { content: newMessage.value })
  newMessage.value = ''
}

onMounted(async () => {
  Echo.connector.pusher.connection.bind('connected', () => {
    console.log('✅ Подключено к Pusher')
  })

  Echo.private(`deal.${props.deal.id}`)
    .listen('.App\\Events\\NewMessageSent', async (e) => {
      messages.value.push({
        id: e.id,
        content: e.content,
        user: e.user,
        created_at: e.created_at,
        read_by_me: false,
      })
      await nextTick()
      markMessagesAsRead()
    })

  await loadMessages()
})
</script>

<template>
  <Head title="Сделка" />

  <div class="max-w-4xl mx-auto mt-8 space-y-6">
    <h1 class="text-2xl font-bold text-gray-800">Сделка #{{ deal.id }}</h1>

    <!-- [ОБНОВЛЕНО] аватар текущего пользователя -->
    <p>
      <img
        :src="avatarUrl(user)"
        alt="Аватар"
        class="w-4 h-4 rounded-full object-cover border"
        loading="lazy"
        decoding="async"
        @error="onImgErr"
      />
      Продавец:
      <a
        :href="route('users.show', { user: deal.offer.user.id })"
        class="text-blue-600 hover:underline"
      >
        {{ deal.offer.user.name }}
      </a>
    </p>

    <p>Описание {{ deal.offer.description }}</p>
    <p>Полное описание {{ deal.offer.full_description }}</p>
    <p>Сумма: {{ deal.total_price }} ₽</p>
    <p>Статус: {{ deal.status }}</p>

    <div v-if="deal.status === 'paid'">
      <button class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
        Подтвердить получение
      </button>
    </div>

    <div class="mt-6">
      <h2 class="font-semibold text-lg mb-2">Чат с продавцом</h2>

      <div class="border rounded p-4 bg-white max-h-96 overflow-y-auto space-y-2">
        <div v-for="m in messages" :key="m.id" class="text-sm flex items-start gap-2">

          <!-- [ОБНОВЛЕНО] аватар собеседника с lazy + fallback -->
          <img
            v-if="m.user && m.user.name !== 'Система'"
            :src="avatarUrl(m.user)"
            alt="avatar"
            class="h-8 w-8 rounded-full object-cover"
            loading="lazy"
            decoding="async"
            @error="onImgErr"
          />

          <div>
            <span :class="m.user.name === 'Система' ? 'text-yellow-700 font-semibold' : 'font-semibold text-gray-900'">
              {{ m.user.name }}:
            </span>
            <span>{{ m.content }}</span>
            <span class="text-xs text-gray-400 ml-2">
              {{ new Date(m.created_at).toLocaleString(undefined, { day:'2-digit', month:'2-digit', year:'numeric', hour:'2-digit', minute:'2-digit' }) }}
            </span>
            <span v-if="m.read_by_me" class="text-xs text-gray-500 ml-2">✓ Прочитано</span>
          </div>
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
