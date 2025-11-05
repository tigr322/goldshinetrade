<script setup>
import AppLayout from '@/Layouts/AppLayout.vue'
import { Head } from '@inertiajs/vue3'

defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
</script>

<template>
  <Head title="Аккаунты" />
  <div class="max-w-7xl mx-auto py-8">
    <h1 class="text-2xl font-semibold text-gray-900 mb-4">Аккаунты</h1>
    <div class="bg-white shadow rounded-xl p-6 text-gray-600">
      Раздел аккаунтов. Содержимое будет добавлено позже.
    </div>
  </div>
</template>

