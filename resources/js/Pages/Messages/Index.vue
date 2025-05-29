<script setup>
import AppLayout from '@/Layouts/AppLayout.vue'
import { Link } from '@inertiajs/vue3'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

const props = defineProps({
  messages: Array,
})
</script>

<template>
    <Head title="Мои сообщения" />
  <div class="max-w-4xl mx-auto py-10">
    <h2 class="text-xl font-semibold text-gray-900 mb-6">Мои сообщения</h2>

    <div v-if="messages.length === 0" class="text-gray-500">
      Сообщений пока нет.
    </div>

    <ul v-else class="space-y-4">
      <li
        v-for="msg in messages"
        :key="msg.id"
        class="bg-white border border-gray-200 shadow-sm rounded-lg p-4"
      >
        <div class="flex justify-between items-center mb-2">
          <span class="text-sm font-semibold text-cyan-700">
            От: {{ msg.user?.name ?? 'Неизвестный' }}
          </span>
          <span class="text-xs text-gray-400">Сделка: {{ msg.deal?.id ?? '—' }}</span>
        </div>
        <p class="text-sm text-gray-800 mb-2">{{ msg.content }}</p>

        <div v-if="msg.deal?.id">
          <Link
            :href="route('deals.show', msg.deal.id)"
            class="inline-block text-sm text-cyan-600 hover:underline"
          >
            Перейти к сделке #{{ msg.deal.id }}
          </Link>
        </div>
      </li>
    </ul>
  </div>
</template>