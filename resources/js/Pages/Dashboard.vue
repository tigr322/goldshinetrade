<!--
  This example requires some changes to your config:
  
  ```
  // tailwind.config.js
  const colors = require('tailwindcss/colors')
  
  module.exports = {
    // ...
    theme: {
      extend: {
        colors: {
          cyan: colors.cyan,
        },
      },
    },
    plugins: [
      // ...
      require('@tailwindcss/forms'),
    ],
  }
  ```
-->

<script setup>
import { ref } from 'vue'
import { Link } from '@inertiajs/vue3'
import { useForm } from '@inertiajs/vue3'

import {
  Dialog,
  DialogPanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
  TransitionChild,
  TransitionRoot,
  
} from '@headlessui/vue'
import {
  Bars3CenterLeftIcon,
  BellIcon,
  ClockIcon,
  CogIcon,
  CreditCardIcon,
  DocumentChartBarIcon,
  HomeIcon,
  QuestionMarkCircleIcon,
  ScaleIcon,
  ShieldCheckIcon,
  UserGroupIcon,
  XMarkIcon,
  
} from '@heroicons/vue/24/outline'
import {
  BanknotesIcon,
  BuildingOfficeIcon,
  CheckCircleIcon,
  ChevronDownIcon,
  ChevronRightIcon,
  MagnifyingGlassIcon,
  XCircleIcon
} from '@heroicons/vue/20/solid'

const props = defineProps({
  title: String,
  user: Object,
  balance: String,
  offers_count: Number,
  deals_count: Number,
  messages_count: Number,
  reviews_received_count: Number,
  reviews_given_count: Number,
  withdrawals: Array,
  adress: String,
})
const notifications = [
  { id: 1, text: 'Вы получили новое сообщение', href: '/messages' },
  { id: 2, text: 'Ваш заказ успешно оформлен', href: '/orders' },
 
]
defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
const fileInput = ref(null)

const form = useForm({
  photo: null,
})

const triggerFileInput = () => {
  fileInput.value?.click()
}

const handleFileChange = (e) => {
  const file = e.target.files[0]
  if (file) {
    form.photo = file
    form.post('/profile/photo', {
      onSuccess: () => form.reset('photo'),
    })
  }
}
const statusStyles = {
  success: 'bg-green-100 text-green-800',
  processing: 'bg-yellow-100 text-yellow-800',
  failed: 'bg-gray-100 text-gray-800',
}

const sidebarOpen = ref(false)
</script>
<template>
    <!--
      This example requires updating your template:
  
      ```
      <html class="h-full bg-gray-100">
      <body class="h-full">
      ```
    -->
    <div class="min-h-full">
     
  
      <!-- Static sidebar for desktop -->
      
  
      <div class="flex flex-1 flex-col">
        <div class="flex h-16 flex-shrink-0 border-b border-gray-200 bg-white lg:border-none">
          
          <!-- Search bar -->
          <div class="flex flex-1 justify-between px-4 sm:px-6 lg:mx-auto lg:max-w-6xl lg:px-8">
            <div class="flex flex-1">
              <form class="flex w-full md:ml-0" action="#" method="GET">
                <label for="search-field" class="sr-only">Search</label>
                <div class="relative w-full text-gray-400 focus-within:text-gray-600">
                  <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center" aria-hidden="true">
                    <MagnifyingGlassIcon class="h-5 w-5" aria-hidden="true" />
                  </div>
                  <input id="search-field" name="search-field" class="block h-full w-full border-transparent py-2 pl-8 pr-3 text-gray-900 placeholder-gray-500 focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm" placeholder="Поиск" type="search" />
                </div>
              </form>
            </div>
            <div class="ml-4 flex items-center md:ml-6">
              <Menu as="div" class="relative">
    <MenuButton
      class="rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
    >
      <span class="sr-only">Оповещения</span>
      <BellIcon class="h-6 w-6" aria-hidden="true" />
    </MenuButton>

    <transition
      enter-active-class="transition duration-100 ease-out"
      enter-from-class="transform scale-95 opacity-0"
      enter-to-class="transform scale-100 opacity-100"
      leave-active-class="transition duration-75 ease-in"
      leave-from-class="transform scale-100 opacity-100"
      leave-to-class="transform scale-95 opacity-0"
    >
      <MenuItems
        class="absolute right-0 z-10 mt-2 w-64 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
      >
        <div class="py-1">
          <template v-if="notifications.length">
            <MenuItem
              v-for="n in notifications"
              :key="n.id"
              v-slot="{ active }"
            >
              <a
                :href="n.href"
                :class="[
                  active ? 'bg-gray-100' : '',
                  'block px-4 py-2 text-sm text-gray-700'
                ]"
              >
                {{ n.text }}
              </a>
            </MenuItem>
          </template>
          <template v-else>
            <div class="px-4 py-2 text-sm text-gray-500">Нет новых уведомлений</div>
          </template>
        </div>
      </MenuItems>
    </transition>
  </Menu>
            
              <!-- Profile dropdown -->
              <Menu as="div" class="relative ml-3">
                <div>
                  <MenuButton class="flex max-w-xs items-center rounded-full bg-white text-sm focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2 lg:rounded-md lg:p-2 lg:hover:bg-gray-50">
                    <img class="h-8 w-8 rounded-full" :src="`/storage/${props.user.photo ?? 'default.jpg'}`" alt="" />
                    <span class="ml-3 hidden text-sm font-medium text-gray-700 lg:block"><span class="sr-only">Open user menu for </span>{{ props.user.name }}</span>
                    <ChevronDownIcon class="ml-1 hidden h-5 w-5 flex-shrink-0 text-gray-400 lg:block" aria-hidden="true" />
                  </MenuButton>
                </div>
                <transition enter-active-class="transition ease-out duration-100" enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100" leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100" leave-to-class="transform opacity-0 scale-95">
                  <MenuItems class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                    <MenuItem v-slot="{ active }">
                    <Link
                        href="/profile"
                        :class="[active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm text-gray-700']"
                    >
                       Профиль
                    </Link>
                    </MenuItem>


                    <MenuItem v-slot="{ active }">
                      <a href="#" :class="[active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm text-gray-700']">Настройки</a>
                    </MenuItem>
                    <MenuItem v-slot="{ active }">
                    <Link
                        href="/logout"
                        method="post"
                        as="button"
                        :class="[active ? 'bg-gray-100' : '', 'block w-full text-left px-4 py-2 text-sm text-gray-700']">
                        Выйти
                    </Link>
                    </MenuItem>

                  </MenuItems>
                </transition>
              </Menu>
            </div>
          </div>
        </div>
        <main class="flex-1 pb-8">
          <!-- Page header -->
          <div class="bg-white shadow">
            <div class="px-4 sm:px-6 lg:mx-auto lg:max-w-6xl lg:px-8">
              <div class="py-6 md:flex md:items-center md:justify-between lg:border-t lg:border-gray-200">
                <div class="min-w-0 flex-1">
                  <!-- Profile -->
                  <div class="flex items-center">
                 
                
                    <div>
              
                      <div class="flex items-center">
                        <button
                      @click="triggerFileInput"
                      class="flex max-w-xs items-center rounded-full bg-white text-sm focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2 lg:rounded-md lg:p-2 lg:hover:bg-gray-50"
                    >
                    <img class="h-16 w-16 rounded-full object-cover" :src="`/storage/${props.user.photo ?? 'default.jpg'}`" alt="Фото профиля" />                      </button>
                      <input
                        type="file"
                        ref="fileInput"
                        @change="handleFileChange"
                        accept="image/*"
                        class="hidden"
                      />  
                        <h1 class="ml-3 text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:leading-9">Здравствуйте, {{ props.user.name }}</h1>
                      </div>
                      <dl class="mt-6 flex flex-col sm:ml-3 sm:mt-1 sm:flex-row sm:flex-wrap">
                        <dt class="sr-only">Company</dt>
                        <dd class="flex items-center text-sm font-medium capitalize text-gray-500 sm:mr-6">
                          <CreditCardIcon class="mr-1.5 h-5 w-5 flex-shrink-0 text-gray-400" aria-hidden="true" />
                          {{ props.user.balance }}
                        </dd>
                        <dt class="sr-only">Статус аккаунта</dt>
                        
                        <dd
                        class="mt-3 flex items-center text-sm font-medium capitalize sm:mr-6 sm:mt-0"
                        :class="user.is_verified ? 'text-green-600' : 'text-red-500'"
                      >
                        <template v-if="user.is_verified">
                          <CheckCircleIcon class="mr-1.5 h-5 w-5 flex-shrink-0 text-green-500" />
                          Аккаунт подтвержден
                        </template>
                        <template v-else>
                          <XMarkIcon class="mr-1.5 h-5 w-5 flex-shrink-0 text-red-500" />
                          Не подтвержден
                        </template>
                      </dd>
                      </dl>
                    </div>
                  </div>
                </div>
                <div class="mt-6 flex space-x-3 md:mt-0 md:ml-4">
                  <Link
    :href="route('wallet.topup')"
    class="inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
  >
    Пополнить кошелек
  </Link>
                  <button type="button" class="inline-flex items-center rounded-md border border-transparent bg-cyan-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2">Вывести деньги</button>
                </div>
              </div>
            </div>
          </div>
  
          <div class="mt-8">
            <div class="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
              <h2 class="text-lg font-medium leading-6 text-gray-900">Просмотреть все счета</h2>
              <div class="mt-2 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
                <!-- Card -->
                <div v-for="card in cards" :key="card.name" class="overflow-hidden rounded-lg bg-white shadow">
                  <div class="p-5">
                    <div class="flex items-center">
                      <div class="flex-shrink-0">
                        <component :is="card.icon" class="h-6 w-6 text-gray-400" aria-hidden="true" />
                      </div>
                      <div class="ml-5 w-0 flex-1">
                        <dl>
                          <dt class="truncate text-sm font-medium text-gray-500">{{ card.name }}</dt>
                          <dd>
                            <div class="text-lg font-medium text-gray-900">{{ card.amount }}</div>
                          </dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                  <div class="bg-gray-50 px-5 py-3">
                    <div class="text-sm">
                      <a :href="card.href" class="font-medium text-cyan-700 hover:text-cyan-900">Подробнее</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
  
            <h2 class="mx-auto mt-8 max-w-6xl px-4 text-lg font-medium leading-6 text-gray-900 sm:px-6 lg:px-8">Активности</h2>

<!-- Таблица для больших экранов -->
<div class="hidden sm:block">
  <div class="mt-2 mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
    <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
      <table class="min-w-full divide-y divide-gray-300">
        <thead class="bg-gray-50">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Название</th>
            <th scope="col" class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Сумма</th>
            <th scope="col" class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Статус</th>
            <th scope="col" class="px-6 py-3 text-left text-sm font-semibold text-gray-900">Дата</th>
            <th scope="col" class="relative px-6 py-3"><span class="sr-only">Подробнее</span></th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200 bg-white">
          <tr v-for="item in withdrawals" :key="item.id">
            <td class="whitespace-nowrap px-6 py-4 text-sm text-gray-900">{{ item.name }}</td>
            <td class="whitespace-nowrap px-6 py-4 text-sm text-gray-500">{{ item.amount }} {{ item.currency }}</td>
            <td class="whitespace-nowrap px-6 py-4 text-sm text-gray-500">{{ item.status }}</td>
            <td class="whitespace-nowrap px-6 py-4 text-sm text-gray-500">
              <time :datetime="item.datetime">{{ item.date }}</time>
            </td>
            <td class="relative whitespace-nowrap px-6 py-4 text-right text-sm font-medium">
              <a :href="item.href" class="text-indigo-600 hover:text-indigo-900">Подробнее</a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Список для мобильных -->
<div class="shadow sm:hidden">
  <ul role="list" class="mt-2 divide-y divide-gray-200 overflow-hidden shadow sm:hidden">
    <li v-for="item in withdrawals" :key="item.id">
      <a :href="item.href" class="block bg-white px-4 py-4 hover:bg-gray-50">
        <span class="flex items-center space-x-4">
          <span class="flex flex-1 space-x-2 truncate">
            <BanknotesIcon class="h-5 w-5 flex-shrink-0 text-gray-400" aria-hidden="true" />
            <span class="flex flex-col truncate text-sm text-gray-500">
              <span class="truncate">{{ item.name }}</span>
              <span>
                <span class="font-medium text-gray-900">{{ item.amount }}</span> {{ item.currency }}
              </span>
              <time :datetime="item.datetime">{{ item.date }}</time>
            </span>
          </span>
          <ChevronRightIcon class="h-5 w-5 flex-shrink-0 text-gray-400" aria-hidden="true" />
        </span>
      </a>
    </li>
  </ul>



  
              <nav class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3" aria-label="Pagination">
                <div class="flex flex-1 justify-between">
                  <a href="#" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:text-gray-500">Previous</a>
                  <a href="#" class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:text-gray-500">Next</a>
                </div>
              </nav>
            </div>
  
            <!-- Activity table (small breakpoint and up) -->
            <div class="hidden sm:block">
              <div class="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
                <div class="mt-2 flex flex-col">
                  <div class="min-w-full overflow-hidden overflow-x-auto align-middle shadow sm:rounded-lg">
                    <table class="min-w-full divide-y divide-gray-200">
                      <thead>
                        <tr>
                          <th class="bg-gray-50 px-6 py-3 text-left text-sm font-semibold text-gray-900" scope="col">Обмены</th>
                          <th class="bg-gray-50 px-6 py-3 text-right text-sm font-semibold text-gray-900" scope="col">Сумма</th>
                          <th class="hidden bg-gray-50 px-6 py-3 text-left text-sm font-semibold text-gray-900 md:block" scope="col">Статус</th>
                          <th class="bg-gray-50 px-6 py-3 text-right text-sm font-semibold text-gray-900" scope="col">Дата</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-200 bg-white">
                        <tr v-for="transaction in transactions" :key="transaction.id" class="bg-white">
                          <td class="w-full max-w-0 whitespace-nowrap px-6 py-4 text-sm text-gray-900">
                            <div class="flex">
                              <a :href="transaction.href" class="group inline-flex space-x-2 truncate text-sm">
                                <BanknotesIcon class="h-5 w-5 flex-shrink-0 text-gray-400 group-hover:text-gray-500" aria-hidden="true" />
                                <p class="truncate text-gray-500 group-hover:text-gray-900">{{ transaction.name }}</p>
                              </a>
                            </div>
                          </td>
                          <td class="whitespace-nowrap px-6 py-4 text-right text-sm text-gray-500">
                            <span class="font-medium text-gray-900">{{ transaction.amount }}</span>
                            {{ transaction.currency }}
                          </td>
                          <td class="hidden whitespace-nowrap px-6 py-4 text-sm text-gray-500 md:block">
                            <span :class="[statusStyles[transaction.status], 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium capitalize']">{{ transaction.status }}</span>
                          </td>
                          <td class="whitespace-nowrap px-6 py-4 text-right text-sm text-gray-500">
                            <time :datetime="transaction.datetime">{{ transaction.date }}</time>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <!-- Pagination -->
                    <nav class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6" aria-label="Pagination">
                      <div class="hidden sm:block">
                        <p class="text-sm text-gray-700">
                          Showing
                          {{ ' ' }}
                          <span class="font-medium">1</span>
                          {{ ' ' }}
                          to
                          {{ ' ' }}
                          <span class="font-medium">10</span>
                          {{ ' ' }}
                          of
                          {{ ' ' }}
                          <span class="font-medium">20</span>
                          {{ ' ' }}
                          results
                        </p>
                      </div>
                      <div class="flex flex-1 justify-between sm:justify-end">
                        <a href="#" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Previous</a>
                        <a href="#" class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Next</a>
                      </div>
                    </nav>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  </template>
  
<script>
import AppLayout from '@/Layouts/AppLayout.vue'
</script>
