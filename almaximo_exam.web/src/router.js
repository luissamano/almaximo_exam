import Vue from 'vue'
import Router from 'vue-router'
import Productos from "./components/Productos.vue"

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'productos',
      component: Productos
    }
  ]
})
