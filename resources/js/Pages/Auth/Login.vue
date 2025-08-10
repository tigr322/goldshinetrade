<script setup>
import Checkbox from '@/Components/Checkbox.vue'
import GuestLayout from '@/Layouts/GuestLayout.vue'
import InputError from '@/Components/InputError.vue'
import InputLabel from '@/Components/InputLabel.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import TextInput from '@/Components/TextInput.vue'
import { Head, Link, useForm, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

defineProps({
  canResetPassword: { type: Boolean },
  status: { type: String },
})

const form = useForm({
  email: '',
  password: '',
  remember: false,
})

const page = usePage()
const errors = computed(() => page.props.errors || {})

const submit = () => {
  form.post(route('login'), {
    onFinish: () => form.reset('password'),
  })
}
</script>

<template>
  <Head title="Вход в GoldShineTrade" />

  <div class="relative isolate min-h-screen bg-white flex">
    <!-- Градиентный фон -->
    <div
      aria-hidden="true"
      class="pointer-events-none absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
    >
      <div
        class="relative left-1/2 aspect-[1155/678] w-[72.1875rem] -translate-x-1/2 rotate-[30deg] bg-gradient-to-tr from-cyan-400 via-cyan-500 to-emerald-400 opacity-40"
        style="clip-path: polygon(74% 44%, 100% 59%, 97% 79%, 86% 100%, 58% 93%, 35% 100%, 0 76%, 18% 51%, 34% 32%, 58% 28%, 66% 12%, 79% 0, 89% 18%)"
      />
    </div>

    <!-- Левая колонка -->
    <div class="flex flex-1 flex-col justify-center py-12 px-4 sm:px-6 lg:flex-none lg:px-20 xl:px-24">
      <div class="mx-auto w-full max-w-sm lg:w-96">
        <!-- Лого + заголовок -->
        <div class="text-center sm:text-left">
          <Link href="/" class="-m-1.5 p-1.5 inline-flex items-center gap-2">
            <img class="h-auto w-auto rounded-md object-contain" src="/storage/iconca.png" alt="GoldShineTrade" />
            <span class="sr-only">GoldShineTrade</span>
          </Link>
          <h1 class="mt-6 text-2xl sm:text-3xl font-bold tracking-tight text-gray-900">
            Войди в свой аккаунт GoldShineTrade
          </h1>
          <p class="mt-2 text-sm text-gray-600">
            Быстрый вход — через Google/VK или по почте и паролю.
          </p>
        </div>

        <!-- Форма -->
        <div class="mt-8 bg-white rounded-2xl shadow-lg p-6 sm:p-8 border border-gray-100">
          <!-- OAuth -->
          <p class="text-sm font-medium text-gray-700">Вход в систему</p>
          <div class="mt-3 grid grid-cols-2 gap-3">
            <a
              :href="route('oauth.redirect', { provider: 'google' })"
              class="inline-flex w-full justify-center items-center gap-2 rounded-xl border border-gray-300 bg-white py-2.5 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 transition"
            >
              <img src="/images/google.svg" alt="" class="h-5 w-5" />
              Войти через Google
            </a>

            <a
              :href="route('oauth.redirect', { provider: 'vkontakte' })"
              class="inline-flex w-full justify-center items-center gap-2 rounded-xl border border-gray-300 bg-white py-2.5 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 transition"
            >
              <img src="/images/vk.svg" alt="" class="h-5 w-5" />
              Войти через ВКонтакте
            </a>
          </div>

          <div class="relative mt-8">
            <div class="absolute inset-0 flex items-center">
              <div class="w-full border-t border-gray-200" />
            </div>
            <div class="relative flex justify-center">
              <span class="bg-white px-3 text-xs uppercase tracking-wider text-gray-500">
                или по почте
              </span>
            </div>
          </div>

          <!-- Логин форма -->
          <form class="mt-8 space-y-6" @submit.prevent="submit">
            <div>
              <InputLabel for="email" value="Почта" />
              <TextInput id="email" type="email" v-model="form.email" required autofocus autocomplete="username"
                class="mt-2 block w-full rounded-xl border-gray-300 focus:border-cyan-600 focus:ring-cyan-600"
                placeholder="you@example.com" />
              <InputError class="mt-2" :message="form.errors.email" />
            </div>

            <div>
              <InputLabel for="password" value="Пароль" />
              <TextInput id="password" type="password" v-model="form.password" required autocomplete="current-password"
                class="mt-2 block w-full rounded-xl border-gray-300 focus:border-cyan-600 focus:ring-cyan-600"
                placeholder="••••••••" />
              <InputError class="mt-2" :message="form.errors.password" />
            </div>

            <div class="flex items-center justify-between">
              <label class="inline-flex items-center gap-2 text-sm text-gray-700 select-none">
                <Checkbox v-model:checked="form.remember" id="remember-me" />
                <span>Запомнить меня</span>
              </label>
              <div class="text-sm">
                <a :href="route('password.request')" class="font-medium text-cyan-700 hover:text-cyan-600">
                  Забыли пароль?
                </a>
              </div>
            </div>

            <button type="submit" :disabled="form.processing"
              class="w-full rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white hover:bg-cyan-600 shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-600 disabled:opacity-50 disabled:cursor-not-allowed flex justify-center items-center">
              <svg v-if="form.processing" class="mr-2 h-5 w-5 animate-spin text-white" viewBox="0 0 24 24" fill="none">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
                <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor" />
              </svg>
              Войти
            </button>
          </form>

          <p class="mt-6 text-center text-sm text-gray-600">
            Ещё нет аккаунта?
            <Link :href="route('register')" class="font-medium text-cyan-700 hover:text-cyan-600">Зарегистрируйтесь</Link>
          </p>
        </div>
      </div>
    </div>

    <!-- Правая колонка с характеристиками -->
    <div class="relative hidden lg:flex w-1/2 flex-col justify-center items-center bg-gradient-to-l from-cyan-600 to-cyan-400 p-12 text-white">
      <img src="/storage/iconca.png" alt="GoldShineTrade" class="w-24 h-24 mb-6" />
      <h2 class="text-3xl font-bold mb-4">Почему GoldShineTrade?</h2>
      <ul class="space-y-4 text-lg">
        <li>💱 Мгновенные сделки</li>
        <li>🔒 Безопасность транзакций</li>
        <li>💰 Выгодный курс обмена</li>
        <li>⚡ Моментальные выплаты</li>
        <li>🌍 Работаем по всему миру</li>
      </ul>
    </div>
  </div>
</template>
