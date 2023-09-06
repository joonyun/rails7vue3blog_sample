import { createApp } from 'vue/dist/vue.esm-bundler';
import axios from 'axios'

import Router from '@/main/routes.js';
import Layout from '@/main/views/shared/layout.vue';

const app = createApp(Layout);
const axiosInstance = axios.create({
    withCredentials: true,
})


app.config.globalProperties.$axios = { ...axiosInstance }

app.use(Router)
  .mount('#app')
