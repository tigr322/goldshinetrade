import { createRouter, createWebHistory } from 'vue-router';

const routes = [
  {
    path: '/deals/:id',
    name: 'deal.show',
    component: () => import('@/Pages/Deals/Show.vue'), // Замените на ваш компонент Исправлено на корректный путь с учетом регистра
    },
    // другие маршруты
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
