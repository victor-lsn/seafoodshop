import Vue from 'vue'
import Router from 'vue-router'
import UserHome from "../views/user/home/home";
import login from "../views/user/login/login";
import register from "../views/user/login/register";
import adminHome from "../views/admin/home/home";
import welcome from "../views/admin/home/welcome";
import adminUser from "../views/admin/user/user";

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'UserHome',
      component: UserHome
    },
    {
      path: '/login',
      name: 'login',
      component: login
    },
    {
      path: '/register',
      name: 'register',
      component: register
    },
    {
      path: '/admin/home',
      name: 'adminHome',
      component: adminHome,
      redirect: '/welcome',
      children: [
        {
          path: '/welcome',
          component: welcome
        },
        {
          path: '/users',
          component: adminUser
        }
      ]
    }
  ]
})
