<script setup>
import { Head, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import TextInput from '@/Components/TextInput.vue';

defineProps({
    status: String,
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
  <Head title="Forgot Password" />

  <div class="relative isolate min-h-screen bg-white flex items-center justify-center">
    <!-- Градиентный фон -->
    <div
      aria-hidden="true"
      class="pointer-events-none absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
    >
      <div
        class="relative left-1/2 aspect-[1155/678] w-[72.1875rem] 
               -translate-x-1/2 rotate-[30deg] 
               bg-gradient-to-tr from-cyan-400 via-cyan-500 to-emerald-400 opacity-40"
        style="clip-path: polygon(74% 44%, 100% 59%, 97% 79%, 
                                   86% 100%, 58% 93%, 35% 100%, 
                                   0 76%, 18% 51%, 34% 32%, 
                                   58% 28%, 66% 12%, 79% 0, 89% 18%)"
      />
    </div>

    <!-- Карточка -->
    <AuthenticationCard class="bg-transparent shadow-none" >


      <template #logo>
        <a href="/" class="-m-1.5 p-1.5">
          <img class="h-12 w-auto" src="/storage/iconca.png" alt="GoldShineTrade" />
        </a>
      </template>

      <div class="mb-4 text-sm text-gray-600">
        Забыли пароль? Нет проблем, на вашу почту отправлено сообщение с ссылкой для смены пароля.
      </div>

      <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
        {{ status }}
      </div>

      <form @submit.prevent="submit">
        <div>
          <InputLabel for="email" value="Email" />
          <TextInput
            id="email"
            v-model="form.email"
            type="email"
            class="mt-1 block w-full rounded-xl border-gray-300 focus:border-cyan-600 focus:ring-cyan-600"
            required
            autofocus
            autocomplete="username"
          />
          <InputError class="mt-2" :message="form.errors.email" />
        </div>

        <div class="flex items-center justify-end mt-4">
          <button
            type="submit"
            :disabled="form.processing"
            class="rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white hover:bg-cyan-600 
                   shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 
                   focus-visible:outline-cyan-600 disabled:opacity-50 disabled:cursor-not-allowed flex items-center"
          >
            <svg
              v-if="form.processing"
              class="mr-2 h-5 w-5 animate-spin text-white"
              viewBox="0 0 24 24"
              fill="none"
            >
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
              <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor" />
            </svg>
            Отправить письмо с ссылкой для смены пароля
          </button>
        </div>
      </form>
    </AuthenticationCard>
  </div>
</template>
