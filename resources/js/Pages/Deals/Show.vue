<script setup>
import { ref, onMounted, nextTick, computed  } from 'vue'
import {Head, usePage } from '@inertiajs/vue3'
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


const confirming = ref(false)

const confirmDeal = async () => {
  if (confirming.value) return
  confirming.value = true
  try {
    await axios.post(route('deals.confirm', props.deal.id))
    location.reload()
  } catch (e) {
    console.warn(e)
  } finally {
    confirming.value = false
  }
}

const statusBadgeClass = (s) => {
  switch (s) {
    case 'pending':  return 'bg-amber-50 text-amber-700 ring-amber-200'
    case 'paid':     return 'bg-blue-50 text-blue-700 ring-blue-200'
    case 'released': return 'bg-emerald-50 text-emerald-700 ring-emerald-200'
    case 'canceled': return 'bg-gray-100 text-gray-600 ring-gray-200'
    case 'disputed': return 'bg-rose-50 text-rose-700 ring-rose-200'
    default:         return 'bg-gray-100 text-gray-600 ring-gray-200'
  }
}
const isBuyer = computed(() => user?.id === props.deal?.buyer_id)

// ввод количества (по умолчанию 1 или уже выбранное)
const payQty = ref(props.deal?.quantity || 1)

// максимально можно купить не больше остатка оффера
const maxQty = computed(() => Number(props.deal?.offer?.quantity ?? 1))

// цена за единицу для покупателя (в оффере уже с процентом)
const unitPrice = computed(() => Number(props.deal?.offer?.price ?? 0))

// итог к оплате
const payTotal = computed(() => (Math.max(1, Math.min(payQty.value, maxQty.value)) * unitPrice.value).toFixed(2))

// можно ли показывать форму оплаты (юзер = покупатель и сделка ещё не оплачена)
const canPay = computed(() => isBuyer.value && props.deal?.status === 'pending')

const paying = ref(false)
const pay = async () => {
  if (paying.value) return
  // страховка по диапазону
  const qty = Math.max(1, Math.min(Number(payQty.value || 1), maxQty.value))
  paying.value = true
  try {
    await axios.post(route('deals.pay', props.deal.id), { quantity: qty })
    location.reload() // после успешной оплаты покажется блок подтверждения
  } catch (e) {
    alert(e?.response?.data?.message || 'Не удалось выполнить оплату')
  } finally {
    paying.value = false
  }
}
</script>
<template>
  <Head title="Сделка" />

  <div class="relative isolate min-h-[calc(100vh-5rem)]">
    <!-- Градиентный фон -->
    <div
      aria-hidden="true"
      class="pointer-events-none absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
    >
      <div
        class="relative left-1/2 aspect-[1155/678] w-[72rem] -translate-x-1/2 rotate-[30deg]
               bg-gradient-to-tr from-cyan-300 via-cyan-500 to-emerald-400 opacity-25"
        style="clip-path: polygon(74% 44%, 100% 59%, 97% 79%, 86% 100%, 58% 93%, 35% 100%, 0 76%, 18% 51%, 34% 32%, 58% 28%, 66% 12%, 79% 0, 89% 18%)"
      />
    </div>

    <div class="mx-auto max-w-5xl px-4 py-8 space-y-6">
      <!-- Заголовок + статус -->
      <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
        <h1 class="text-2xl font-bold text-gray-900">
          Сделка <span class="text-gray-500">#{{ deal.id }}</span>
        </h1>
        <span
          class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-medium ring-1"
          :class="statusBadgeClass(deal.status)"
        >
          <span class="inline-block h-2 w-2 rounded-full bg-current opacity-60" />
          {{ deal.status }}
        </span>
      </div>

      <!-- Карточки-инфо -->
      <div class="grid gap-4 sm:grid-cols-3">
        <!-- Продавец -->
        <div class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 p-5 shadow-sm">
          <div class="text-sm text-gray-500">Продавец</div>
          <div class="mt-3 flex items-center gap-3">
            <img
              :src="avatarUrl(deal.offer.user)"
              @error="onImgErr"
              class="h-10 w-10 rounded-full object-cover border"
              alt="avatar"
              loading="lazy"
              decoding="async"
            />
            <div class="min-w-0">
              <a
                :href="route('users.show', { user: deal.offer.user.id })"
                class="font-semibold text-gray-900 hover:text-cyan-700 truncate"
              >
                {{ deal.offer.user.name }}
              </a>
              <div class="text-xs text-gray-500 truncate">{{ deal.offer.game?.name || deal.offer.game_name || 'Игра не указана' }}</div>
            </div>
          </div>
        </div>

        <!-- Сумма -->
        <div class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 p-5 shadow-sm">
          <div class="text-sm text-gray-500">Сумма сделки</div>
          <div class="mt-3 text-2xl font-bold text-gray-900">
            {{ Number(deal.total_price).toLocaleString() }} ₽
          </div>
          <div class="mt-1 text-xs text-gray-500">Итог к оплате покупателя</div>
        </div>

        <!-- Оффер -->
        <div class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 p-5 shadow-sm">
          <div class="text-sm text-gray-500">Оффер</div>
          <div class="mt-1 font-semibold text-gray-900 truncate">{{ deal.offer.title }}</div>
          <div class="mt-1 text-xs text-gray-500 line-clamp-2">
            {{ deal.offer.description || 'Без описания' }}
          </div>
        </div>
      </div>

      <!-- Кнопка подтверждения -->
      <div v-if="deal.status === 'paid'" class="flex justify-end">
        <button
          @click="confirmDeal"
          :disabled="confirming"
          class="inline-flex items-center gap-2 rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white
                     hover:bg-cyan-600 shadow-sm focus-visible:outline focus-visible:outline-2
                     focus-visible:outline-offset-2 focus-visible:outline-cyan-600 disabled:opacity-50"
        >
          <svg v-if="confirming" class="h-4 w-4 animate-spin" viewBox="0 0 24 24" fill="none">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor"/>
          </svg>
          Подтвердить получение
        </button>
      </div>

      <!-- Блок описаний -->
      <div class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 p-6 shadow-sm space-y-2">
        <div class="text-sm text-gray-500">Детали</div>
        <p class="text-gray-800">
          <span class="font-medium text-gray-900">Описание:</span>
          <span class="text-gray-700"> {{ deal.offer.description || '—' }} </span>
        </p>
        <p class="text-gray-800">
          <span class="font-medium text-gray-900">Полное описание:</span>
          <span class="text-gray-700"> {{ deal.offer.full_description || '—' }} </span>
        </p>
      </div>

      <!-- Чат -->
      <div class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 shadow-sm">
        <div class="px-5 pt-5 pb-3 flex items-center justify-between">
          <h2 class="font-semibold text-gray-900">Чат с продавцом</h2>
          <div class="text-xs text-gray-500">Все сообщения сохраняются</div>
        </div>

        <div class="px-5 pb-5">
          <div class="max-h-[50vh] overflow-y-auto space-y-3 pr-1">
            <div v-for="m in messages" :key="m.id" class="flex items-start gap-2"
                 :class="{
                   'justify-end': m.user?.id === user.id,
                   'justify-center': m.user?.name === 'Система'
                 }">

              <!-- Система -->
              <div v-if="m.user?.name === 'Система'"
                   class="mx-auto rounded-full bg-yellow-50 text-yellow-800 text-xs px-3 py-1 ring-1 ring-yellow-200">
                {{ m.content }}
              </div>

              <!-- Сообщение другого пользователя -->
              <template v-else-if="m.user?.id !== user.id">
                <img
                  :src="avatarUrl(m.user)"
                  alt="avatar"
                  class="h-8 w-8 rounded-full object-cover border"
                  loading="lazy"
                  decoding="async"
                  @error="onImgErr"
                />
                <div class="max-w-[75%] rounded-2xl rounded-tl-sm bg-gray-100 px-3 py-2 shadow-sm">
                  <div class="text-xs font-medium text-gray-900">{{ m.user?.name }}</div>
                  <div class="text-sm text-gray-800 whitespace-pre-line">{{ m.content }}</div>
                  <div class="mt-1 text-[11px] text-gray-500">
                    {{ new Date(m.created_at).toLocaleString(undefined,{ day:'2-digit', month:'2-digit', year:'numeric', hour:'2-digit', minute:'2-digit' }) }}
                    <span v-if="m.read_by_me" class="ml-1">• прочитано</span>
                  </div>
                </div>
              </template>

              <!-- Моё сообщение -->
              <template v-else>
                <div class="max-w-[75%] rounded-2xl rounded-tr-sm bg-cyan-600/90 px-3 py-2 text-white shadow-sm">
                  <div class="text-sm whitespace-pre-line">{{ m.content }}</div>
                  <div class="mt-1 text-[11px] text-white/80">
                    {{ new Date(m.created_at).toLocaleString(undefined,{ day:'2-digit', month:'2-digit', year:'numeric', hour:'2-digit', minute:'2-digit' }) }}
                    <span v-if="m.read_by_me" class="ml-1">• прочитано</span>
                  </div>
                </div>
                <img
                  :src="avatarUrl(user)"
                  alt="avatar"
                  class="h-8 w-8 rounded-full object-cover border"
                  loading="lazy"
                  decoding="async"
                  @error="onImgErr"
                />
              </template>
            </div>
          </div>

          <!-- Инпут -->
          <form @submit.prevent="sendMessage" class="mt-4 flex items-center gap-2">
            <input
              v-model="newMessage"
              type="text"
              placeholder="Сообщение..."
              class="flex-1 rounded-xl border border-gray-300 px-4 py-2 focus:border-cyan-600 focus:ring-cyan-600"
            />
            <button
              type="submit"
              class="rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white hover:bg-cyan-600 shadow-sm
                     focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-600"
            >
              Отправить
            </button>
          </form>
        </div>
      </div>
      <!-- Оплата (эскроу) -->
<div v-if="canPay" class="rounded-2xl bg-white/80 backdrop-blur border border-gray-100 p-6 shadow-sm">
  <div class="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-4">
    <div class="space-y-2">
      <div class="text-sm text-gray-500">Покупка</div>

      <div class="flex items-center gap-3">
        <label for="qty" class="text-sm font-medium text-gray-700">Количество</label>
        <input
          id="qty"
          v-model.number="payQty"
          type="number"
          min="1"
          :max="maxQty"
          class="w-28 rounded-xl border border-gray-300 px-3 py-2 text-sm focus:border-cyan-600 focus:ring-cyan-600"
        />
        <span class="text-xs text-gray-500">Доступно: {{ maxQty }}</span>
      </div>

      <div class="text-sm text-gray-600">
        Цена за единицу: <span class="font-semibold text-gray-900">{{ unitPrice.toLocaleString() }} ₽</span>
      </div>
      <div class="text-sm text-gray-600">
        Итог к оплате: <span class="text-lg font-bold text-gray-900">{{ Number(payTotal).toLocaleString() }} ₽</span>
      </div>

      <p class="text-xs text-gray-500">
        Средства будут <span class="font-medium text-gray-700">заморожены</span> до подтверждения получения.
        После подтверждения деньги автоматически перечислятся продавцу.
      </p>
    </div>

    <div class="shrink-0">
      <button
        @click="pay"
        :disabled="paying"
        class="inline-flex items-center gap-2 rounded-xl bg-cyan-700 px-5 py-2.5 text-sm font-semibold text-white
               hover:bg-cyan-600 shadow-sm focus-visible:outline focus-visible:outline-2
               focus-visible:outline-offset-2 focus-visible:outline-cyan-600 disabled:opacity-50"
      >
        <svg v-if="paying" class="h-4 w-4 animate-spin" viewBox="0 0 24 24" fill="none">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
          <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor"/>
        </svg>
        Купить
      </button>
    </div>
  </div>
</div>

    </div>
  </div>
</template>
