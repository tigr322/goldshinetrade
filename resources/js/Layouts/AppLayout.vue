<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { Link, usePage } from '@inertiajs/vue3'
import Echo from '@/echo'
import axios from 'axios'
import { Bars3CenterLeftIcon, XMarkIcon, HomeIcon, ScaleIcon, CreditCardIcon, UserGroupIcon, CogIcon, QuestionMarkCircleIcon, ShieldCheckIcon } from '@heroicons/vue/24/outline'
import { Dialog, DialogPanel, TransitionChild, TransitionRoot } from '@headlessui/vue'

// Sidebar state
const sidebarOpen = ref(false)

// Navigation and secondary navigation
const navigation = [
  { name: 'Дом', href: route('dashboard'), icon: HomeIcon },
  { name: 'Обмен', href: route('offers.index'), icon: ScaleIcon },
  { name: 'Мои карты', href: route('cards.index'), icon: CreditCardIcon },
  { name: 'Мои Сообщения', href: route('mymessages'), icon: UserGroupIcon },
]

const secondaryNavigation = [
  { name: 'Настройки', href: '#', icon: CogIcon },
  { name: 'Помощь', href: '#', icon: QuestionMarkCircleIcon },
  { name: 'Безопасность', href: '#', icon: ShieldCheckIcon },
]

const page = usePage()
const user = page.props.auth.user

// Add Admin section to navigation if user is an admin or moderator
if (user && Array.isArray(user.roles) && user.roles.some(role => ['admin', 'moderator'].includes(role.name))) {
  navigation.push({
    name: 'Администрирование',
    href: route('admin.dashboard'),
    icon: ShieldCheckIcon,
  })
}

// Notification system
const notifications = ref([])  // List of notifications

// Function to display notifications
const showNotification = (message) => {
  notifications.value.unshift({
    id: Date.now(),
    text: `Новое сообщение от ${message.user.name}: ${message.content}`.slice(0, 50),
    href: `/deals/${message.deal_id}`,
  })
}

// Messages handling
const props = defineProps({
  userDeals: Array // List of all user deals
})

const messages = ref([]) // List of messages
const newMessage = ref('') // New message for sending

// Mark messages as read
const markMessagesAsRead = async () => {
  const unreadIds = messages.value
    .filter(msg => msg.user?.id !== user.id && !msg.read_by_me && typeof msg.id === 'number')
    .map(msg => msg.id)

  if (unreadIds.length > 0) {
    try {
      await axios.post(route('messages.markRead'), {
        message_ids: unreadIds,
      })

      // Mark them as read on client side
      messages.value.forEach(msg => {
        if (unreadIds.includes(msg.id)) {
          msg.read_by_me = true
        }
      })
    } catch (err) {
      console.warn('Ошибка при отметке сообщений как прочитанных:', err)
    }
  }
}

// Load messages for each deal
const loadMessages = async () => {
  for (const deal of props.userDeals) {
    const res = await axios.get(route('messages.index', deal.id))
    messages.value.push(...res.data.reverse())
  }

  await nextTick()
  markMessagesAsRead()
}

// Send new message
const sendMessage = async () => {
  if (!newMessage.value.trim()) return

  await axios.post(route('messages.store', props.deal.id), {
    content: newMessage.value,
  })

  newMessage.value = ''
}

// Listen to events for balance updates and new messages
onMounted(async () => {
  // Connect to private channel for each deal
  echo.connector.pusher.connection.bind('connected', () => {
    console.log('✅ Подключено к Pusher')
  })

  // Subscribe to channels for each user's deals
  for (const deal of props.userDeals) {
    Echo.private(`deal.${deal.id}`)
      .listen('.App\\Events\\NewMessageSent', async (e) => {
        console.log('📨 Новое сообщение:', e)

        // Add new message to the list
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
  }

  await loadMessages()
})
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Mobile Sidebar -->
    <TransitionRoot as="template" :show="sidebarOpen">
      <Dialog as="div" class="relative z-40 lg:hidden" @close="sidebarOpen = false">
        <TransitionChild as="template"
          enter="transition-opacity ease-linear duration-300"
          enter-from="opacity-0"
          enter-to="opacity-100"
          leave="transition-opacity ease-linear duration-300"
          leave-from="opacity-100"
          leave-to="opacity-0">
          <div class="fixed inset-0 bg-gray-600 bg-opacity-75" />
        </TransitionChild>

        <div class="fixed inset-0 z-40 flex">
          <TransitionChild as="template"
            enter="transition ease-in-out duration-300 transform"
            enter-from="-translate-x-full"
            enter-to="translate-x-0"
            leave="transition ease-in-out duration-300 transform"
            leave-from="translate-x-0"
            leave-to="-translate-x-full">
            <DialogPanel class="relative flex w-full max-w-xs flex-1 flex-col bg-cyan-700 pt-5 pb-4">
              <div class="absolute top-0 right-0 -mr-12 pt-2">
                <button type="button"
                        class="ml-1 flex h-10 w-10 items-center justify-center rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                        @click="sidebarOpen = false">
                  <span class="sr-only">Закрыть</span>
                  <XMarkIcon class="h-6 w-6 text-white" />
                </button>
              </div>

              <div class="flex items-center px-4">
                <img class="h-20 w-auto" src="/storage/icon.png" alt="Logo" />
              </div>

              <nav class="mt-5 divide-y divide-cyan-800 overflow-y-auto px-2" aria-label="Sidebar">
                <div class="space-y-1">
                  <Link v-for="item in navigation"
                        :key="item.name"
                        :href="item.href"
                        class="group flex items-center px-2 py-2 text-base font-medium rounded-md"
                        :class="currentRoute === item.href ? 'bg-cyan-800 text-white' : 'text-cyan-100 hover:text-white hover:bg-cyan-600'">
                    <component :is="item.icon" class="mr-4 h-6 w-6 text-cyan-200" />
                    {{ item.name }}
                  </Link>
                </div>
                <div class="mt-6 pt-6 space-y-1">
                  <Link v-for="item in secondaryNavigation"
                        :key="item.name"
                        :href="item.href"
                        class="group flex items-center px-2 py-2 text-base font-medium text-cyan-100 hover:text-white hover:bg-cyan-600 rounded-md">
                    <component :is="item.icon" class="mr-4 h-6 w-6 text-cyan-200" />
                    {{ item.name }}
                  </Link>
                </div>
              </nav>
            </DialogPanel>
          </TransitionChild>
          <div class="w-14 flex-shrink-0" aria-hidden="true" />
        </div>
      </Dialog>
    </TransitionRoot>

    <!-- Desktop Sidebar -->
    <div class="hidden lg:fixed lg:inset-y-0 lg:flex lg:w-64 lg:flex-col">
      <div class="flex flex-grow flex-col overflow-y-auto bg-cyan-700 pt-5">
        <div class="flex items-center px-4">
          <img class="h-45 w-auto" src="/storage/icon.png" alt="Logo" />
        </div>

        <nav class="mt-5 flex-1 divide-y divide-cyan-800 overflow-y-auto px-2" aria-label="Sidebar">
          <div class="space-y-1">
            <Link v-for="item in navigation"
                  :key="item.name"
                  :href="item.href"
                  class="group flex items-center px-2 py-2 text-sm font-medium rounded-md leading-6"
                  :class="currentRoute === item.href ? 'bg-cyan-800 text-white' : 'text-cyan-100 hover:text-white hover:bg-cyan-600'">
              <component :is="item.icon" class="mr-4 h-6 w-6 text-cyan-200" />
              {{ item.name }}
            </Link>
          </div>
          <div class="mt-6 pt-6 space-y-1">
            <Link v-for="item in secondaryNavigation"
                  :key="item.name"
                  :href="item.href"
                  class="group flex items-center px-2 py-2 text-sm font-medium text-cyan-100 hover:text-white hover:bg-cyan-600 rounded-md leading-6">
              <component :is="item.icon" class="mr-4 h-6 w-6 text-cyan-200" />
              {{ item.name }}
            </Link>
          </div>
        </nav>
      </div>
    </div>

    <!-- Topbar for mobile toggle -->
    <div class="lg:pl-64">
      <div class="sticky top-0 z-10 bg-white pl-1 pt-1 sm:pl-3 sm:pt-3 lg:hidden">
        <button type="button"
                class="ml-1 flex h-10 w-10 items-center justify-center rounded-md text-gray-500 hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-cyan-500"
                @click="sidebarOpen = true">
          <span class="sr-only">Открыть меню</span>
          <Bars3CenterLeftIcon class="h-6 w-6" />
        </button>
      </div>

      <!-- Page Content -->
      <main class="p-4">
        <slot />
        <!-- Add Footer here -->
      </main>
    </div>
  </div>
</template>
