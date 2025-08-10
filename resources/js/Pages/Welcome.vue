<!-- resources/js/Pages/Welcome.vue -->
<script setup>
import { Head, Link } from '@inertiajs/vue3'
import { ref } from 'vue'
import { Dialog, DialogPanel } from '@headlessui/vue'
import { Bars3Icon, XMarkIcon } from '@heroicons/vue/24/outline'

const mobileMenuOpen = ref(false)

// Можно подложить реальные ссылки позже
const navigation = [
  { name: 'О нас', href: '#about' },
  { name: 'Как это работает', href: '#how' },
  { name: 'Преимущества', href: '#benefits' },
]
</script>

<template>
  <Head title="Добро пожаловать в GoldShineTrade!" />

  <div class="relative isolate bg-white">
    <!-- Градиентный фон -->
    <div
      aria-hidden="true"
      class="pointer-events-none absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
    >
      <div
        class="relative left-1/2 aspect-[1155/678] w-[72.1875rem] -translate-x-1/2 rotate-[30deg] bg-gradient-to-tr from-indigo-300 via-fuchsia-300 to-pink-300 opacity-30"
        style="clip-path: polygon(74% 44%, 100% 59%, 97% 79%, 86% 100%, 58% 93%, 35% 100%, 0 76%, 18% 51%, 34% 32%, 58% 28%, 66% 12%, 79% 0, 89% 18%)"
      />
    </div>

    <!-- Навигация -->
    <header class="px-6 pt-6 lg:px-8">
      <nav class="mx-auto flex max-w-7xl items-center justify-between" aria-label="Global">
        <div class="flex lg:flex-1 items-center gap-3">
          <Link href="/" class="-m-1.5 p-1.5 inline-flex items-center gap-2">
            <img class="h-10 w-10 rounded-md object-contain" src="/storage/iconca.png" alt="GoldShineTrade" />
            <span class="sr-only">GoldShineTrade</span>
          </Link>
        </div>

        <div class="flex lg:hidden">
          <button
            type="button"
            class="-m-2.5 inline-flex items-center justify-center rounded-md p-2.5 text-gray-700"
            @click="mobileMenuOpen = true"
          >
            <span class="sr-only">Открыть меню</span>
            <Bars3Icon class="h-6 w-6" aria-hidden="true" />
          </button>
        </div>

        <div class="hidden lg:flex lg:gap-x-10">
          <a
            v-for="item in navigation"
            :key="item.name"
            :href="item.href"
            class="text-sm font-semibold leading-6 text-gray-900 hover:text-gray-700"
          >
            {{ item.name }}
          </a>
        </div>

        <div class="hidden lg:flex lg:flex-1 lg:justify-end items-center gap-4">
          <Link :href="route('login')" class="text-sm font-semibold leading-6 text-gray-900 hover:text-gray-700">
            Войти
          </Link>
          <Link
            :href="route('register')"
            class="rounded-xl bg-cyan-700 px-4 py-2.5 text-sm font-semibold text-white hover:bg-cyan-600 shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-600"
          >
            Регистрация
          </Link>
        </div>
      </nav>

      <!-- Мобильное меню -->
      <Dialog as="div" :open="mobileMenuOpen" @close="mobileMenuOpen = false">
        <DialogPanel
          focus
          class="fixed inset-0 z-50 overflow-y-auto bg-white px-6 py-6 lg:hidden"
        >
          <div class="flex items-center justify-between">
            <Link href="/" class="-m-1.5 p-1.5 inline-flex items-center gap-2">
              <img class="h-10 w-10 rounded-md object-contain" src="/storage/iconca.png" alt="GoldShineTrade" />
              <span class="sr-only">GoldShineTrade</span>
            </Link>
            <button type="button" class="-m-2.5 rounded-md p-2.5 text-gray-700" @click="mobileMenuOpen = false">
              <span class="sr-only">Закрыть меню</span>
              <XMarkIcon class="h-6 w-6" aria-hidden="true" />
            </button>
          </div>
          <div class="mt-6 flow-root">
            <div class="-my-6 divide-y divide-gray-200/70">
              <div class="space-y-2 py-6">
                <a
                  v-for="item in navigation"
                  :key="item.name"
                  :href="item.href"
                  @click="mobileMenuOpen = false"
                  class="-mx-3 block rounded-lg py-2 px-3 text-base font-semibold leading-7 text-gray-900 hover:bg-gray-50"
                >
                  {{ item.name }}
                </a>
              </div>
              <div class="py-6 space-y-3">
                <Link
                  :href="route('login')"
                  class="-mx-3 block rounded-lg py-2.5 px-3 text-base font-semibold leading-7 text-gray-900 hover:bg-gray-50"
                  @click="mobileMenuOpen = false"
                >
                  Войти
                </Link>
                <Link
                  :href="route('register')"
                  class="-mx-3 block rounded-lg py-2.5 px-3 text-base font-semibold leading-7 text-white bg-cyan-700 hover:bg-cyan-600 rounded-xl text-center"
                  @click="mobileMenuOpen = false"
                >
                  Регистрация
                </Link>
              </div>
            </div>
          </div>
        </DialogPanel>
      </Dialog>
    </header>

    <!-- HERO -->
    <main>
      <section class="relative">
        <div class="mx-auto max-w-7xl px-6 pt-16 pb-20 sm:pt-24 sm:pb-28 lg:px-8">
          <div class="mx-auto max-w-3xl text-center">
            <h1 class="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
              GoldShineTrade — обменяй игровые достижения на реальные возможности!
            </h1>
            <p class="mt-6 text-lg leading-8 text-gray-600">
              Продавайте и получайте реальные денежные средства в течение всего дня — без очередей и без лишних шагов.
            </p>
            <div class="mt-10 flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link
                :href="route('register')"
                class="w-full sm:w-auto rounded-xl bg-cyan-700 px-5 py-3 text-base font-semibold leading-7 text-white shadow-sm hover:bg-cyan-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-600"
              >
                Начать сейчас
              </Link>
              <Link
                :href="route('LearnMore')"
                class="w-full sm:w-auto text-base font-semibold leading-7 text-gray-900"
              >
                Узнать больше <span aria-hidden="true">→</span>
              </Link>
            </div>

            <!-- бейджи доверия -->
            <div class="mt-10 flex flex-wrap items-center justify-center gap-x-6 gap-y-3 text-sm text-gray-500">
              <span class="inline-flex items-center rounded-full bg-gray-100 px-3 py-1">
                24/7 поддержка
              </span>
              <span class="inline-flex items-center rounded-full bg-gray-100 px-3 py-1">
                Безопасные сделки
              </span>
              <span class="inline-flex items-center rounded-full bg-gray-100 px-3 py-1">
                Моментальные выплаты
              </span>
            </div>
          </div>
        </div>
      </section>

      <!-- Как это работает -->
      <section id="how" class="bg-gray-50">
        <div class="mx-auto max-w-7xl px-6 py-16 lg:px-8">
          <div class="mx-auto max-w-3xl text-center">
            <h2 class="text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">Как это работает</h2>
            <p class="mt-3 text-gray-600">
              Три простых шага — и средства у вас.
            </p>
          </div>
          <div class="mt-10 grid gap-6 sm:grid-cols-3">
            <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div class="text-sm font-semibold text-cyan-700">Шаг 1</div>
              <h3 class="mt-2 text-lg font-semibold text-gray-900">Авторизация</h3>
              <p class="mt-2 text-gray-600">Войдите через Google/VK или по e-mail и паролю.</p>
            </div>
            <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div class="text-sm font-semibold text-cyan-700">Шаг 2</div>
              <h3 class="mt-2 text-lg font-semibold text-gray-900">Создание сделки</h3>
              <p class="mt-2 text-gray-600">Оформите предложение и закрепите договорённости в чате.</p>
            </div>
            <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
              <div class="text-sm font-semibold text-cyan-700">Шаг 3</div>
              <h3 class="mt-2 text-lg font-semibold text-gray-900">Выплата</h3>
              <p class="mt-2 text-gray-600">Подтвердите передачу — получите деньги моментально.</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Преимущества -->
      <section id="benefits">
        <div class="mx-auto max-w-7xl px-6 py-16 lg:px-8">
          <div class="grid gap-12 lg:grid-cols-2 lg:items-center">
            <div>
              <h2 class="text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">Почему GoldShineTrade</h2>
              <ul class="mt-6 space-y-4 text-gray-700">
                <li class="flex gap-3">
                  <span class="mt-1 h-2 w-2 rounded-full bg-cyan-600"></span>
                  Эскроу-сделки: заморозка средств до подтверждения.
                </li>
                <li class="flex gap-3">
                  <span class="mt-1 h-2 w-2 rounded-full bg-cyan-600"></span>
                  Реал-тайм чат между продавцом и покупателем.
                </li>
                <li class="flex gap-3">
                  <span class="mt-1 h-2 w-2 rounded-full bg-cyan-600"></span>
                  2FA и верификация e-mail для безопасности.
                </li>
              </ul>
              <div class="mt-8 flex gap-4">
                <Link
                  :href="route('register')"
                  class="rounded-xl bg-cyan-700 px-5 py-3 text-base font-semibold text-white hover:bg-cyan-600 shadow-sm"
                >
                  Зарегистрироваться
                </Link>
                <Link :href="route('login')" class="px-5 py-3 text-base font-semibold text-gray-900">
                  Войти
                </Link>
              </div>
            </div>

            <div class="relative">
              <div class="rounded-3xl border border-gray-200 bg-white p-6 shadow-lg">
                <img
                  src="/storage/landing/preview.png"
                  alt="Превью интерфейса GoldShineTrade"
                  class="w-full rounded-xl"
                  @error="$event.target.closest('.relative').classList.add('opacity-0')"
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- CTA -->
      <section class="relative overflow-hidden">
        <div class="mx-auto max-w-7xl px-6 py-16 lg:px-8">
          <div class="rounded-3xl bg-gradient-to-r from-cyan-700 to-sky-600 p-8 md:p-12 text-center text-white shadow-lg">
            <h2 class="text-2xl font-bold sm:text-3xl">Готовы попробовать?</h2>
            <p class="mt-3 text-white/90">Создайте аккаунт за минуту и начните продавать сегодня.</p>
            <div class="mt-6 flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link
                :href="route('register')"
                class="w-full sm:w-auto rounded-xl bg-white/95 px-5 py-3 text-base font-semibold text-cyan-700 hover:bg-white"
              >
                Начать бесплатно
              </Link>
              <Link :href="route('LearnMore')" class="w-full sm:w-auto text-base font-semibold text-white">
                Узнать больше →
              </Link>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Футер -->
    <footer class="mt-10 border-t">
      <div class="mx-auto max-w-7xl px-6 py-8 lg:px-8 text-center text-sm text-gray-500">
        <div class="space-x-4">
          <Link :href="route('privacy')" class="hover:underline">Политика конфиденциальности</Link>
          <Link :href="route('policy.offer')" class="hover:underline">Пользовательское соглашение</Link>
          <Link :href="route('policy.terms')" class="hover:underline">Условия использования</Link>
        </div>
        <p class="mt-3">© {{ new Date().getFullYear() }} GoldShineTrade</p>
      </div>
    </footer>
  </div>
</template>
