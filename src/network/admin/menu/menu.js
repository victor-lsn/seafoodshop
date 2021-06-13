import {request} from "../../request";

export function getMenu(roleId) {
  return request({
    url: "/admin/menu",
    method: "POST",
    params:{
      roleId:roleId
    }
  })
}

export function getAllMenu() {
  return request({
    url: "/admin/allMenu",
    method: "POST",
  })
}

export function getMenuById(id){
  return request({
    url: "/admin/getMenuById",
    method: "POST",
    params:{
      id
    }
  })
}

export function updateMenuById(menuForm){
  return request({
    url: "/admin/updateMenuById",
    method: "POST",
    params:menuForm
  })
}

export function addMenu(name,path,parent,icon) {
  return request({
    url: "/admin/addMenu",
    method: "POST",
    params:{
      name:name,
      path:path,
      parent:parent,
      icon:icon
    }
  })
}

export function getOrderCountByMonth(){
  return request({
    url: "/admin/getOrderCountByMonth",
    method: "POST",
  })
}


export function getOrderMoneyByMonth(){
  return request({
    url: "/admin/getOrderMoneyByMonth",
    method: "POST",
  })
}

export function getSaleCountByCategory(){
  return request({
    url:"/admin/getSaleCountByCategory",
    method:"POST",
  })
}

export function getOrderCountMap(){
  return request({
    url:"/admin/getOrderCountMap",
    method:"POST",
  })
}

export function getOrderCountByMonth2(year){
  return request({
    url: "/admin/getOrderCountByMonth2",
    method: "POST",
    params:{
      year
    }
  })
}


export function getOrderMoneyByMonth2(year){
  return request({
    url: "/admin/getOrderMoneyByMonth2",
    method: "POST",
    params:{
      year
    }
  })
}

export function getOrderCountMap2(year){
  return request({
    url:"/admin/getOrderCountMap2",
    method:"POST",
    params:{
      year
    }
  })
}
