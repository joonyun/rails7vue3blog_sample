import { createWebHistory, createRouter } from 'vue-router'
import Main from '@/main/views/index.vue';

const router = createRouter({
  history: createWebHistory(`/main`),
  routes: [
    { path: '/', component: Main, name: 'root_path' },  
  ]
});

export default router; 
