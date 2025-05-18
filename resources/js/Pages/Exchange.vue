<script setup>
import { ref } from 'vue'
import { Inertia } from '@inertiajs/inertia'

const form = ref({
  from_currency: 'USD',
  to_currency: 'RUB',
  amount: '',
  payment_method: 'bank_card',
})

const currencies = [
  { id: 'USD', name: 'Доллары США (USD)' },
  { id: 'EUR', name: 'Евро (EUR)' },
  { id: 'RUB', name: 'Рубли (RUB)' },
  { id: 'GOLD', name: 'Золото (игровая валюта)' },
]

const paymentMethods = [
  { id: 'bank_card', name: 'Банковская карта' },
  { id: 'qiwi', name: 'QIWI' },
  { id: 'yoomoney', name: 'ЮMoney' },
  { id: 'crypto', name: 'Криптовалюта' },
]

const submit = () => {
  Inertia.post('/exchange', form.value)
}
</script>

<template>
  <div class="space-y-8">
    <div class="bg-white shadow sm:rounded-lg">
      <div class="px-4 py-5 sm:p-6">
        <h3 class="text-lg font-medium leading-6 text-gray-900">Обмен валют</h3>
        <div class="mt-5">
          <form @submit.prevent="submit">
            <div class="grid grid-cols-1 gap-6 sm:grid-cols-3">
              <!-- Отдаете -->
              <div>
                <label for="from_currency" class="block text-sm font-medium text-gray-700">Отдаете</label>
                <select
                  id="from_currency"
                  v-model="form.from_currency"
                  name="from_currency"
                  class="mt-1 block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-cyan-500 focus:outline-none focus:ring-cyan-500 sm:text-sm"
                >
                  <option v-for="currency in currencies" :key="currency.id" :value="currency.id">
                    {{ currency.name }}
                  </option>
                </select>
              </div>

              <!-- Получаете -->
              <div>
                <label for="to_currency" class="block text-sm font-medium text-gray-700">Получаете</label>
                <select
                  id="to_currency"
                  v-model="form.to_currency"
                  name="to_currency"
                  class="mt-1 block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-cyan-500 focus:outline-none focus:ring-cyan-500 sm:text-sm"
                >
                  <option v-for="currency in currencies" :key="currency.id" :value="currency.id">
                    {{ currency.name }}
                  </option>
                </select>
              </div>

              <!-- Сумма -->
              <div>
                <label for="amount" class="block text-sm font-medium text-gray-700">Сумма</label>
                <div class="mt-1 relative rounded-md shadow-sm">
                  <input
                    type="number"
                    v-model="form.amount"
                    name="amount"
                    id="amount"
                    class="block w-full rounded-md border-gray-300 pl-3 pr-12 py-2 focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm"
                    placeholder="0.00"
                  />
                  <div class="absolute inset-y-0 right-0 flex items-center">
                    <label for="currency" class="sr-only">Currency</label>
                    <span class="h-full py-2 pl-2 pr-4 border-transparent bg-transparent text-gray-500 sm:text-sm">
                      {{ form.from_currency }}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Способ оплаты -->
            <div class="mt-6">
              <label class="block text-sm font-medium text-gray-700">Способ оплаты</label>
              <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-4 sm:gap-x-4">
                <div v-for="method in paymentMethods" :key="method.id" class="relative flex cursor-pointer">
                  <input
                    :id="method.id"
                    v-model="form.payment_method"
                    :value="method.id"
                    name="payment_method"
                    type="radio"
                    class="peer hidden"
                  />
                  <label
                    :for="method.id"
                    class="flex-1 rounded-lg border border-gray-300 bg-white py-2 px-4 text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none peer-checked:border-cyan-500 peer-checked:ring-1 peer-checked:ring-cyan-500"
                  >
                    {{ method.name }}
                  </label>
                </div>
              </div>
            </div>

            <!-- Кнопка обмена -->
            <div class="mt-8">
              <button
                type="submit"
                class="inline-flex items-center rounded-md border border-transparent bg-cyan-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
              >
                Обменять
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Активные оферты -->
    <div class="bg-white shadow sm:rounded-lg">
      <div class="px-4 py-5 sm:p-6">
        <h3 class="text-lg font-medium leading-6 text-gray-900">Активные оферты</h3>
        <div class="mt-5">
          <p class="text-sm text-gray-500">Здесь будут отображаться ваши активные оферты на обмен.</p>
        </div>
      </div>
    </div>
  </div>
</template>