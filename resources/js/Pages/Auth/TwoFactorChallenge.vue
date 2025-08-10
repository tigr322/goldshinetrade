<!-- resources/js/Pages/Auth/TwoFactorChallenge.vue -->
<script setup>
import { ref, computed, onMounted } from 'vue'
import { useForm, usePage, router } from '@inertiajs/vue3'

// Режим ввода: 'totp' | 'recovery'
const mode = ref<'totp' | 'recovery'>('totp')

const page = usePage()
const flash = computed(() => page.props.flash || {})

const form = useForm({
  code: '',
  recovery_code: '',
})

const sending = ref(false)

onMounted(() => {
  // автофокус
  document.getElementById('code')?.focus()
})

// Отправляем в стандартный Fortify маршрут: POST /two-factor-challenge
async function submit() {
  sending.value = true
  form.clearErrors()

  await form.post('/two-factor-challenge', {
    preserveScroll: true,
    onFinish: () => { sending.value = false },
    onSuccess: () => {
      // Fortify сам редиректит на intended; здесь ничего не нужно.
    },
  })
}

// удобства ввода TOTP: только цифры, авто-оверрайт, автосабмит на 6 символов
function onCodeInput(e) {
  const v = (e.target.value || '').replace(/\D+/g, '').slice(0, 6)
  form.code = v
  if (v.length === 6) submit()
}

function onPaste(e) {
  const text = (e.clipboardData?.getData('text') || '').replace(/\D+/g, '').slice(0, 6)
  if (text) {
    e.preventDefault()
    form.code = text
    if (text.length === 6) submit()
  }
}

function switchMode(next) {
  mode.value = next
  // очистим встречные поля
  form.code = ''
  form.recovery_code = ''
  // фокус
  requestAnimationFrame(() => {
    if (next === 'totp') document.getElementById('code')?.focus()
    else document.getElementById('recovery_code')?.focus()
  })
}
</script>

<template>
  <div class="min-h-screen bg-gray-50 flex items-center justify-center px-4">
    <div class="w-full max-w-md">
      <div class="bg-white shadow-lg rounded-2xl p-6 md:p-8">
        <h1 class="text-2xl font-semibold tracking-tight text-gray-900">
          Подтверждение входа
        </h1>
        <p class="mt-2 text-gray-600">
          Введите код из приложения-аутентификатора
          <span v-if="mode === 'totp'">или используйте резервный код</span>.
        </p>

        <!-- Flash статус -->
        <div v-if="flash.status" class="mt-4 rounded-lg bg-green-50 text-green-800 px-4 py-2 text-sm">
          {{ flash.status }}
        </div>

        <!-- Ошибки -->
        <div v-if="form.errors.code" class="mt-4 rounded-lg bg-red-50 text-red-700 px-4 py-2 text-sm">
          {{ form.errors.code }}
        </div>
        <div v-if="form.errors.recovery_code" class="mt-4 rounded-lg bg-red-50 text-red-700 px-4 py-2 text-sm">
          {{ form.errors.recovery_code }}
        </div>

        <form @submit.prevent="submit" class="mt-6 space-y-5">
          <div v-if="mode === 'totp'">
            <label for="code" class="block text-sm font-medium text-gray-700">Код из приложения</label>
            <input
              id="code"
              name="code"
              type="text"
              inputmode="numeric"
              autocomplete="one-time-code"
              pattern="[0-9]*"
              maxlength="6"
              :value="form.code"
              @input="onCodeInput"
              @paste="onPaste"
              class="mt-2 w-full rounded-xl border border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 px-4 py-3 text-lg tracking-widest text-center"
              placeholder="••••••"
            />
            <p class="mt-2 text-xs text-gray-500">Код меняется каждые ~30 секунд.</p>
          </div>

          <div v-else>
            <label for="recovery_code" class="block text-sm font-medium text-gray-700">Резервный код</label>
            <input
              id="recovery_code"
              name="recovery_code"
              type="text"
              v-model.trim="form.recovery_code"
              class="mt-2 w-full rounded-xl border border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 px-4 py-3"
              placeholder="XXXX-XXXX или XXXXXXXX"
            />
            <p class="mt-2 text-xs text-gray-500">Резервный код можно использовать один раз.</p>
          </div>

          <div class="flex items-center justify-between">
            <button
              type="button"
              class="text-sm font-medium text-indigo-600 hover:text-indigo-700"
              @click="switchMode(mode === 'totp' ? 'recovery' : 'totp')"
            >
              <template v-if="mode === 'totp'">Ввести резервный код</template>
              <template v-else>Ввести код из приложения</template>
            </button>
          </div>

          <button
            type="submit"
            :disabled="sending || (mode === 'totp' ? !form.code : !form.recovery_code)"
            class="w-full inline-flex items-center justify-center rounded-xl bg-indigo-600 hover:bg-indigo-700 disabled:bg-indigo-300 text-white font-medium h-11 transition"
          >
            <svg v-if="sending" class="animate-spin -ml-1 mr-3 h-5 w-5" viewBox="0 0 24 24" fill="none">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" fill="currentColor"/>
            </svg>
            Подтвердить
          </button>
        </form>

        <div class="mt-6 text-xs text-gray-500 leading-relaxed">
          Проблемы со входом? Используйте резервный код. Если нет доступа к кодам — обратитесь в поддержку для сброса 2FA.
        </div>
      </div>

      <p class="mt-6 text-center text-sm text-gray-500">
        Если это не вы — закройте страницу и смените пароль.
      </p>
    </div>
  </div>
</template>

<style scoped>
/* эстетика: трекинг для TOTP уже через tracking-widest */
</style>
