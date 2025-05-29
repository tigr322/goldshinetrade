<script setup>
import { ref } from 'vue'
import { Link } from '@inertiajs/inertia-vue3'  // <-- импорт Link
import route from 'ziggy-js'

const user = ref({
  name: 'Иван Иванов',
  email: 'ivan@example.com',
  profile_photo_url: '/path/to/photo.jpg',
})

const balance = ref(1000)

const navigation = ref([
  { name: 'Главная', href: 'dashboard' },
  { name: 'Обмен', href: 'exchange' },
])

const secondaryNavigation = ref([
  { name: 'Настройки', href: 'settings' },
  { name: 'Выход', href: 'logout' },
])

const mobileMenuOpen = ref(false)

const isCurrent = (name) => {
  return window.location.pathname === route(name)
}
</script>

<template>
     <Head title="Главная" />
  <nav>
    <div>
      <div>
        <div>
          <div>
            <Link 
              v-for="item in navigation" 
              :key="item.name" 
              :href="route(item.href)"
              :class="[
                isCurrent(item.href) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white',
                'rounded-md px-3 py-2 text-sm font-medium'
              ]"
            >
              {{ item.name }}
            </Link>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>
