import Vue from 'vue'
import Router from 'vue-router'
import UserHome from "../views/user/home/home";
import login from "../views/user/login/login";
import register from "../views/user/login/register";
import adminHome from "../views/admin/home/home";
import welcome from "../views/admin/home/welcome";
import adminUser from "../views/admin/user/user";
import adminRole from "../views/admin/role/role";
import adminPermission from "../views/admin/permission/permission";
import adminCategory from "../views/admin/category/category";
import adminGoods from "../views/admin/good/goods";

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
        },
        {
          path: '/roles',
          component: adminRole
        },
        {
          path: '/permission',
          component: adminPermission
        },
        {
          path:'/category',
          component: adminCategory
        },
        {
          path:'/goods',
          component: adminGoods
        }
      ]
    }
  ]
})
