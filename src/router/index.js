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
import adminNews from "../views/admin/news/news";
import adminAdvert from "../views/admin/advert/advert";
import adminOrder from "../views/admin/order/order";
import search from "../views/user/search/search";
import goodInfo from "../views/user/goodInfo/goodInfo";
import address from "../views/user/address/address";
import shopcar from "../views/user/shopcar/shopcar";
import userChat from "../views/user/chat/chat";
import userOrder from "../views/user/order/order";

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
      path: '/search',
      name: 'search',
      component: search
    },
    {
      path: '/goodInfo',
      name: 'goodInfo',
      component: goodInfo
    },
    {
      path: '/address',
      name: 'address',
      component: address
    },
    {
      path: '/shopcar',
      name: 'shopcar',
      component: shopcar
    },
    {
      path: '/chat',
      name: 'chat',
      component: userChat
    },
    {
      path:'/order',
      name: 'userOrder',
      component: userOrder,
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
          path: '/category',
          component: adminCategory
        },
        {
          path: '/goods',
          component: adminGoods
        },
        {
          path: '/orders',
          component: adminOrder
        },
        {
          path: '/news',
          component: adminNews
        },
        {
          path: '/advert',
          component: adminAdvert
        }
      ]
    }
  ]
})
