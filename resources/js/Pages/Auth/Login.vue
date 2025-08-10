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

  <div class="min-h-screen bg-gray-50 flex">
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

        <!-- Статус / общая ошибка -->
        <div v-if="status" class="mt-6 rounded-lg bg-green-50 px-4 py-2 text-sm text-green-800">
          {{ status }}
        </div>
        <div v-if="errors.default" class="mt-4 rounded-lg bg-red-50 px-4 py-2 text-sm text-red-700">
          {{ errors.default }}
        </div>

        <!-- Карточка формы -->
        <div class="mt-8 bg-white rounded-2xl shadow-lg p-6 sm:p-8 border border-gray-100">
          <!-- OAuth -->
          <p class="text-sm font-medium text-gray-700">Вход в систему</p>
          <div class="mt-3 grid grid-cols-2 gap-3">
            <!-- Google -->
            <a
              :href="route('oauth.redirect', { provider: 'google' })"
              class="inline-flex w-full justify-center items-center gap-2 rounded-xl border border-gray-300 bg-white py-2.5 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 transition"
            >
            <svg
              class="h-5 w-5 mr-2"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 48 48"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              style="display: block;"
            >
              <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
              <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
              <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
              <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
              <path fill="none" d="M0 0h48v48H0z"/>
            </svg>
              Войти через Google
            </a>

            <!-- VK -->
            <a
              :href="route('oauth.redirect', { provider: 'vkontakte' })"
              class="inline-flex w-full justify-center items-center gap-2 rounded-xl border border-gray-300 bg-white py-2.5 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 transition"
            >
              <img src="/images/vk.svg" alt="" class="h-5 w-5" />
              Войти через ВКонтакте
            </a>
          </div>

          <!-- Разделитель -->
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

          <!-- Форма логина -->
          <form class="mt-8 space-y-6" @submit.prevent="submit">
            <div>
              <InputLabel for="email" value="Почта" />
              <TextInput
                id="email"
                type="email"
                v-model="form.email"
                required
                autofocus
                autocomplete="username"
                class="mt-2 block w-full rounded-xl border-gray-300 focus:border-cyan-600 focus:ring-cyan-600"
                placeholder="you@example.com"
              />
              <InputError class="mt-2" :message="form.errors.email" />
            </div>

            <div>
              <InputLabel for="password" value="Пароль" />
              <TextInput
                id="password"
                type="password"
                v-model="form.password"
                required
                autocomplete="current-password"
                class="mt-2 block w-full rounded-xl border-gray-300 focus:border-cyan-600 focus:ring-cyan-600"
                placeholder="••••••••"
              />
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

            <button
          type="submit"
          :disabled="form.processing"
          class="w-full rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white hover:bg-cyan-600 shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-600 disabled:opacity-50 disabled:cursor-not-allowed flex justify-center items-center"
        >
          <svg v-if="form.processing" class="mr-2 h-5 w-5 animate-spin text-white" viewBox="0 0 24 24" fill="none">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
            <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor"/>
          </svg>
          Войти
        </button>



          </form>

          <!-- Регистрация -->
          <p class="mt-6 text-center text-sm text-gray-600">
            Ещё нет аккаунта?
            <Link :href="route('register')" class="font-medium text-cyan-700 hover:text-cyan-600">Зарегистрируйтесь</Link>
          </p>
        </div>
      </div>
    </div>

    <!-- Правая картинка -->
    <div class="relative hidden w-0 flex-1 lg:block">
      <img
        class="absolute inset-0 h-full w-full object-cover"
        src="https://images.unsplash.com/photo-1505904267569-f02eaeb45a4c?auto=format&fit=crop&w=2100&q=80"
        alt="GoldShineTrade"
      />
      <!-- затемнение для контраста (легкое) -->
      <div class="absolute inset-0 bg-gradient-to-l from-black/20 to-transparent" aria-hidden="true" />
    </div>
  </div>
</template>
