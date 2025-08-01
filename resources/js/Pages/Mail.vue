<script setup>
import { router } from '@inertiajs/vue3'

const resend = () => {
  router.post('/email/verification-notification')
}
</script>
<template>
    <div v-if="!$page.props.auth.user.email_verified_at">
      <p>Пожалуйста, подтвердите ваш email — ссылка отправлена на почту.</p>
      <button @click="resend">Отправить повторно</button>
    </div>
  </template>
  
