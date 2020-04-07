import Vue from 'vue'
import Router from 'vue-router'
import store from '@/store'
import NProgress from 'nprogress'

const login = resolve => require(["@/views/login/login.vue"], resolve)
const dashboard = resolve => require(["@/views/dashboard/dashboard.vue"], resolve)
const listar = resolve => require(["@/views/dashboard/partials/listar/listar.vue"], resolve)
const adicionar = resolve => require(["@/views/dashboard/partials/adicionar/adicionar.vue"], resolve)
const PageNotFound = resolve => require(["@/views/PageNotFound/PageNotFound.vue"], resolve)

Vue.use(Router)

let routes = [
  {
    path: "*",
    name: "PageNotFound",
    component: PageNotFound,
    meta: {
      title: 'Eleva Educação | Página não encontrada',
      protected: false
    }
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: dashboard,
    meta: {
      title: 'Eleva Educação | Dashboard',
      protected: false
    },
    props: true,
    children: [
      {
        path: "/dashboard/listar/:table",
        name: "listar",
        component: listar,
        props: true,
        meta: {
          title: 'Eleva Educação | Listar',
          protected: true
        }
      },{
        path: "/dashboard/adicionar/:table",
        name: "adicionar",
        component: adicionar,
        props: true,
        meta: {
          title: 'Eleva Educação | Adicionar Novo',
          protected: true
        }
      },{
        path: "/dashboard/editar/:table/:id",
        name: "editar",
        component: adicionar,
        props: true,
        meta: {
          title: 'Eleva Educação | Adicionar Novo',
          protected: true
        }
      }    
    ],
  },  
  {
    path: "/",
    name: "login",
    component: login,
    meta: {
      title: 'Eleva Educação | Login',
      protected: false
    },
    props: true
  } 
]

const router = new Router({
  mode: "history",
  base: process.env.BASE_URL,
  linkActiveClass: "current",
  routes: routes
})

router.beforeResolve((to, from, next) => {  
  const nearestWithTitle = to.matched
    .slice()
    .reverse()
    .find(r => r.meta && r.meta.title)

  if (nearestWithTitle) document.title = nearestWithTitle.meta.title
  Array.from(document.querySelectorAll("[data-vue-router-controlled]")).map(
    el => el.parentNode.removeChild(el)
  )

  NProgress.start()
  next()
})

router.afterEach((to, from) => {
  window.scrollTo( 0, 0 )
  NProgress.done()
})

export default router