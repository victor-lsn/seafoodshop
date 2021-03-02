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
