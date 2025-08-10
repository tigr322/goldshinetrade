<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    
        <Head title="Log in" />
        <div v-if="status" class="mb-4 text-sm font-medium text-green-600">
            {{ status }}
        </div>
    <div class="flex min-h-full">
      <div class="flex flex-1 flex-col justify-center py-12 px-4 sm:px-6 lg:flex-none lg:px-20 xl:px-24">
        <div class="mx-auto w-full max-w-sm lg:w-96">
          <div>

            <a href="/" class="-m-1.5 p-1.5">
              <span class="sr-only">Your Company</span>
              <img class="h-12 w-auto" src="/storage/iconca.png" alt="GoldShineTrade" />
            </a>
            <h2 class="mt-6 text-3xl font-bold tracking-tight text-gray-900">Войди в свой аккаунт GoldShineTrade</h2>
           
          </div>
  
          <div class="mt-8">
            <div>
              <div>
                <p class="text-sm font-medium text-gray-700">Вход в систему</p>
  
                <div class="mt-1 grid grid-cols-2 gap-3">
                  <!-- Google -->
                  <a
  :href="route('oauth.redirect', { provider: 'google' })"
  class="inline-flex w-full justify-center rounded-md border border-gray-300 bg-white py-2 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
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
                    class="inline-flex w-full justify-center rounded-md border border-gray-300 bg-white py-2 px-4 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50"
                  >
                    <img src="/images/vk.svg" alt="" class="h-5 w-5 mr-2" />
                    Войти через ВКонтакте
                  </a>
                </div>

              </div>
  
              <div class="relative mt-6">
                <div class="absolute inset-0 flex items-center" aria-hidden="true">
                  <div class="w-full border-t border-gray-300" />
                </div>
                <div class="relative flex justify-center text-sm">
                  <span class="bg-white px-2 text-gray-500">Or continue with</span>
                </div>
              </div>
            </div>
  
            <div class="mt-6">
                <form @submit.prevent="submit">
                <div>
                  <label for="email" class="block text-sm font-medium text-gray-700">Почта</label>
                 
                    <div>
               

                <TextInput
                    id="email"
                    type="email"
                   class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
                    v-model="form.email"
                    required
                    autofocus
                    autocomplete="username"
                />

                <InputError class="mt-2" :message="form.errors.email" />
            </div>
                    
                 
                </div>
  
                <div class="space-y-1">
                  <label for="password" class="block text-sm font-medium text-gray-700">Пароль</label>
                  <div class="mt-1">
                    
               

                <TextInput
                    id="password"
                    type="password"
                    class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
                    v-model="form.password"
                    required
                    autocomplete="current-password"
                />

                <InputError class="mt-2" :message="form.errors.password" />
            

                  </div>
                </div>
  
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
                    <label for="remember-me" class="ml-2 block text-sm text-gray-900">Запомнить меня</label>
                  </div>
  
                  <div class="text-sm">
                    <a :href="route('password.request')" class="font-medium text-indigo-600 hover:text-indigo-500">Забыли пароль?</a>
                  </div>
                </div>
  
                <div>
                  <button type="submit" class="flex w-full justify-center rounded-md border border-transparent bg-cyan-700 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-cyan-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">Войти</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="relative hidden w-0 flex-1 lg:block">
        <img class="absolute inset-0 h-full w-full object-cover" src="https://images.unsplash.com/photo-1505904267569-f02eaeb45a4c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1908&q=80" alt="" />
      </div>
    </div>

  </template>
  