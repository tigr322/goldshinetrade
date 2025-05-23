<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Профиль" />
  
    <AuthenticatedLayout>
      <template #header>
        <h2 class="text-2xl font-bold text-cyan-600">Профиль пользователя</h2>
      </template>
  
      <div class="py-10">
        <div class="mx-auto max-w-4xl space-y-6 px-4">
          <!-- Обновление профиля -->
          <div class="bg-white border border-cyan-100 p-6 shadow-md rounded-2xl">
            <h3 class="text-lg font-semibold text-cyan-600 mb-4">Данные профиля</h3>
            <UpdateProfileInformationForm
              :must-verify-email="mustVerifyEmail"
              :status="status"
              class="max-w-2xl"
            />
          </div>
  
          <!-- Обновление пароля -->
          <div class="bg-white border border-cyan-100 p-6 shadow-md rounded-2xl">
            <h3 class="text-lg font-semibold text-cyan-600 mb-4">Сменить пароль</h3>
            <UpdatePasswordForm class="max-w-2xl" />
          </div>
  
          <!-- Удаление аккаунта -->
          <div class="bg-white border border-red-100 p-6 shadow-md rounded-2xl">
            <h3 class="text-lg font-semibold text-red-600 mb-4">Удалить аккаунт</h3>
            <DeleteUserForm class="max-w-2xl" />
          </div>
        </div>
      </div>
    </AuthenticatedLayout>
  </template>
<script>
import AppLayout from '@/Layouts/AppLayout.vue'
</script>
