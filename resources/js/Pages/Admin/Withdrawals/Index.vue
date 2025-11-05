<script setup>
import AppLayout from '@/Layouts/AppLayout.vue'
import { Head, Link } from '@inertiajs/vue3'

const props = defineProps({
  withdrawals: Object,
})

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
</script>

<template>
  <Head title="Выводы средств" />
  <div class="max-w-7xl mx-auto py-8">
    <h1 class="text-2xl font-semibold text-gray-900 mb-6">Заявки на вывод средств</h1>

    <div class="bg-white shadow rounded-xl overflow-hidden">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Пользователь</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Сумма</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Метод</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Реквизиты</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Статус</th>
            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Создано</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="w in props.withdrawals.data" :key="w.id">
            <td class="px-4 py-3 text-sm text-gray-900">{{ w.id }}</td>
            <td class="px-4 py-3 text-sm text-cyan-700">
              <Link v-if="w.user" :href="route('users.show', { user: w.user.id })" class="hover:underline">
                {{ w.user.name }}
              </Link>
              <span v-else class="text-gray-500">—</span>
            </td>
            <td class="px-4 py-3 text-sm text-gray-900">{{ Number(w.amount).toFixed(2) }} ₽</td>
            <td class="px-4 py-3 text-sm text-gray-700">{{ w.method || '—' }}</td>
            <td class="px-4 py-3 text-sm font-mono text-gray-700">{{ w.details }}</td>
            <td class="px-4 py-3 text-sm">
              <span :class="[
                'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                w.status === 'pending' ? 'bg-yellow-100 text-yellow-800' :
                w.status === 'paid' ? 'bg-green-100 text-green-800' :
                'bg-red-100 text-red-800'
              ]">
                {{ w.status }}
              </span>
            </td>
            <td class="px-4 py-3 text-sm text-gray-500">{{ w.created_at }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div v-if="withdrawals?.links?.length" class="mt-4 flex gap-2">
      <Link v-for="l in withdrawals.links" :href="l.url || '#'" :key="l.label" :class="[
        'px-3 py-1 rounded border text-sm',
        l.active ? 'bg-cyan-600 text-white border-cyan-600' : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-50'
      ]" v-html="l.label" />
    </div>
  </div>
</template>

