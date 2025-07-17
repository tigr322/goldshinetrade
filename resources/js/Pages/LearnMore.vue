<script setup>
import { Head, Link } from '@inertiajs/vue3'
</script>

<template>
  <Head title="О платформе" />

  <div class="max-w-5xl mx-auto py-12 space-y-8">
    <h1 class="text-2xl font-bold text-gray-900 mb-6">О платформе GoldShineTrade</h1>

    <div class="bg-white shadow rounded-xl p-6 space-y-4 text-gray-800 text-sm leading-relaxed">
      <p>
        Наша платформа создана для безопасных сделок с игровыми товарами, валютой и услугами. Мы объединяем продавцов и покупателей, обеспечивая прозрачность, доверие и поддержку на каждом этапе.
      </p>

      <h2 class="text-lg font-semibold text-gray-900">1. Как это работает?</h2>
      <ul class="list-disc list-inside space-y-1">
        <li>Продавец публикует предложение с описанием и ценой.</li>
        <li>Покупатель выбирает интересующее предложение и инициирует сделку.</li>
        <li>Деньги временно блокируются системой до выполнения условий.</li>
        <li>После подтверждения — продавец получает оплату, а покупатель — товар/услугу.</li>
      </ul>

      <h2 class="text-lg font-semibold text-gray-900">2. Гарантия безопасности</h2>
      <p>
        Мы используем проверенные механизмы блокировки средств, а также систему арбитража. Все действия фиксируются, и в случае конфликта мы оперативно подключаем модератора.
      </p>

      <h2 class="text-lg font-semibold text-gray-900">3. Технические особенности</h2>
      <ul class="list-disc list-inside space-y-1">
        <li>Интеграция с Telegram для оповещений и чатов.</li>
        <li>Онлайн-чат между участниками сделки.</li>
        <li>Система пополнения и вывода средств CKassa.</li>
      </ul>

      <h2 class="text-lg font-semibold text-gray-900">4. Поддержка</h2>
      <p>
        У нас работает оперативная поддержка — вы можете обратиться в Telegram или через почту. Мы стараемся отвечать в течение нескольких минут.
      </p>

      <p>
        По любым вопросам: <a href="mailto:goldshinetrade90@gmail.com" class="text-cyan-700 hover:underline">goldshinetrade90@gmail.com</a>
      </p>
    </div>

    <Link
      :href="route('Welcome')"
      class="inline-block text-cyan-600 hover:text-cyan-800 text-sm font-medium"
    >
      ← Вернуться на главную
    </Link>
  </div>
</template>