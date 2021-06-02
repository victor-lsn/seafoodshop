import {request} from "../../request";

export function getAllUser() {
  return request({
    url: "/admin/getAllUser",
    method: "POST"
  })
}


export function getUserPage(search) {
  return request({
    url: "/admin/getUserPage",
    method: "POST",
    params: {
      pageNo: search.pageNo,
      pageSize: search.pageSize,
      username: search.username,
      phone: search.phone,
      role: search.role
    }
  })
}

export function updateStatus(userId, flag) {
  return request({
    url: "/admin/updateStatus",
    method: "POST",
    params: {
      userId: userId,
      flag: flag
    }
  })
}

export function updateRole(userId, roleId) {
  return request({
    url: "/admin/updateRole",
    method: "POST",
    params: {
      userId: userId,
      roleId: roleId
    }
  })
}


export function getUserInfo(userId) {
  return request({
    url: "/admin/getUserInfo",
    method: "POST",
    params: {
      userId: userId
    }
  })
}

export function getAllAdress(userId){
  return request({
    url:"/admin/getAllAddress",
    method:"POST",
    params:{
      userId:userId
    }
  })
}

export function addAddress(addr,userId,realName){
  return request({
    url:"/admin/addAddress",
    method:"POST",
    params:{
      userId:userId,
      addr,
      realName
    }
  })
}


export function deleteAddress(id){
  return request({
    url:"/admin/deleteAddress",
    method:"POST",
    params:{
      id:id
    }
  })
}

export function addShopCar(userId,seafoodId){
  return request({
    url:"/admin/addShopCar",
    method:"POST",
    params:{
      userId,
      seafoodId
    }
  })
}

export function deleteShopCar(userId,seafoodId){
  return request({
    url:"/admin/deleteShopCar",
    method:"POST",
    params:{
      userId,
      seafoodId
    }
  })
}

export function getShopCar(userId){
  return request({
    url:"/admin/getShopCar",
    method:"POST",
    params:{
      userId,
    }
  })
}

export function getCommentList(seafoodId){
  return request({
    url:"/admin/getComment",
    method:"POST",
    params:{
      seafoodId,
    }
  })
}

export function addComment(fromUserId, toUserId, seafoodId, parent, level, content, fromUserName, toUserName){
  return request({
    url:"/admin/addComment",
    method:"POST",
    params:{
      fromUserId,
      toUserId,
      seafoodId,
      parent,
      level,
      content,
      fromUserName,
      toUserName
    }
  })
}

export function getAllWaiter(){
  return request({
    url:"/admin/getAllWaiter",
    method:"POST"
  })
}
