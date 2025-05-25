<script setup>
import { useForm } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
const props = defineProps({ offer: Object })

const form = useForm({
  title: props.offer.title,
  description: props.offer.description,
  price: props.offer.price,
})

const submit = () => {
  form.put(route('admin.offers.update', props.offer.id))
}
</script>

<template>
  <div class="max-w-xl mx-auto py-10">
    <h1 class="text-2xl font-bold text-cyan-700 mb-6">Редактировать оффер</h1>

    <form @submit.prevent="submit" class="space-y-4">
      <div>
        <label class="block font-medium">Заголовок</label>
        <input v-model="form.title" type="text" class="w-full border rounded p-2" />
      </div>

      <div>
        <label class="block font-medium">Описание</label>
        <textarea v-model="form.description" class="w-full border rounded p-2"></textarea>
      </div>

      <div>
        <label class="block font-medium">Цена</label>
        <input v-model="form.price" type="number" class="w-full border rounded p-2" />
      </div>

      <button type="submit" class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
        Сохранить
      </button>
    </form>
  </div>
</template>