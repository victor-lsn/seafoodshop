import {request} from "../../request";

export function getAllRole() {
  return request({
    url: "/admin/getAllRole",
    method: "POST"
  })
}

export function addRole(name, desc) {
  return request({
    url: "/admin/addRole",
    method: "POST",
    params: {
      name: name,
      describe: desc
    }
  })
}

export function deleteRole(roleId) {
  return request({
    url: '/admin/deleteRole',
    method: "POST",
    params: {
      roleId: roleId
    }
  })
}

export function getRoleById(roleId) {
  return request({
    url: "/admin/getRoleById",
    method: "POST",
    params: {
      roleId: roleId
    }
  })
}


export function addRolePermission(roleId, currentIdList) {
  return request({
    url: "/admin/addRolePermission",
    method: "POST",
    params: {
      roleId: roleId,
      currentIdList: currentIdList
    }
  })
}
