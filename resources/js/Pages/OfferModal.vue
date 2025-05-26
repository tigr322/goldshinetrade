
<script setup>
import { ref } from 'vue'

const props = defineProps({
  show: Boolean,
})

const emit = defineEmits(['close', 'accept'])

const close = () => emit('close')
const accept = () => emit('accept')
</script>
  <style scoped>
  .fade-enter-active, .fade-leave-active {
    transition: opacity 0.3s;
  }
  .fade-enter-from, .fade-leave-to {
    opacity: 0;
  }
  </style>
<template>
    <transition name="fade">
      <div v-if="show" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex justify-center items-center">
        <div class="bg-white p-6 rounded-xl shadow-xl max-w-lg w-full space-y-4">
          <h2 class="text-xl font-bold text-gray-800">Пользовательское соглашение</h2>
          <p class="text-sm text-gray-600 overflow-y-auto max-h-60">
            Пользовательское соглашение представляет собой официальное предложение администратора сайта заключить договор на условиях, изложенных ниже. Совершение регистрации, размещение информации и использование функционала сайта означает полное и безоговорочное принятие условий настоящей оферты.
            <br><br>
            1. Предмет оферты: предоставление доступа к функционалу платформы для размещения, покупки и продажи виртуальных товаров и услуг.
            <br>
            2. Пользователь обязуется использовать сайт только в законных целях.
            <br>
            3. Администрация не несет ответственности за действия пользователей.
            <br>
            4. Оферта может быть изменена в одностороннем порядке.
            <br><br>
            Принимая условия оферты, вы соглашаетесь с Политикой конфиденциальности и Правилами платформы.
          </p>
          <div class="flex justify-end gap-2">
            <button @click="close" class="text-gray-600 hover:underline">Закрыть</button>
            <button @click="accept" class="bg-cyan-600 text-white px-4 py-2 rounded hover:bg-cyan-700">
              Принять
            </button>
          </div>
        </div>
      </div>
    </transition>
  </template>
  
  
