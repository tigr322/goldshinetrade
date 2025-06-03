<script setup>
//import AppLayout from '@/Layouts/AppLayout.vue'
//defineOptions({ layout: (h, page) => h(AppLayout, null, () => page) })
</script>

<template>
  <div class="max-w-5xl mx-auto py-12 space-y-8">
    <h1 class="text-2xl font-bold text-gray-900 mb-6">Политика конфиденциальности</h1>

    <div class="bg-white shadow rounded-xl p-6 space-y-4 text-gray-800 text-sm leading-relaxed">
      <p>
        Настоящая Политика конфиденциальности описывает, какие данные мы собираем, как мы их используем и какие у вас есть права.
      </p>

      <h2 class="text-lg font-semibold text-gray-900">1. Сбор данных</h2>
      <ul class="list-disc list-inside space-y-1">
        <li>Мы собираем имя, email, номер телефона и другие данные, необходимые для использования платформы.</li>
        <li>Мы можем автоматически собирать техническую информацию — IP-адрес, тип устройства, браузер.</li>
      </ul>

      <h2 class="text-lg font-semibold text-gray-900">2. Использование данных</h2>
      <ul class="list-disc list-inside space-y-1">
        <li>Для предоставления доступа к сервису, сделкам и чату.</li>
        <li>Для обработки платежей и защиты от мошенничества.</li>
        <li>Для обратной связи и уведомлений.</li>
      </ul>

      <h2 class="text-lg font-semibold text-gray-900">3. Хранение и защита</h2>
      <p>
        Все данные хранятся на защищённых серверах. Мы применяем современные методы защиты, включая шифрование и бэкапы.
      </p>

      <h2 class="text-lg font-semibold text-gray-900">4. Третьи лица</h2>
      <p>
        Мы не передаём ваши данные третьим лицам, за исключением случаев, когда это требуется по закону или необходимо для работы платформы (например, платёжные системы).
      </p>

      <h2 class="text-lg font-semibold text-gray-900">5. Ваши права</h2>
      <ul class="list-disc list-inside space-y-1">
        <li>Вы можете запросить удаление или изменение ваших данных.</li>
        <li>Вы можете отключить получение уведомлений.</li>
        <li>Вы можете полностью удалить аккаунт в любое время.</li>
      </ul>

      <p>
        По всем вопросам пишите нам на <a href="mailto:goldshinetrade90@gmail.com" class="text-cyan-700 hover:underline">goldshinetrade90@gmail.com</a>.
      </p>

      <p class="text-xs text-gray-500 mt-4">
        Последнее обновление: {{ new Date().toLocaleDateString() }} ИНН 233608603524   ФИО Адамян Тигран Павлович
      </p>
    </div>
  </div>
</template>