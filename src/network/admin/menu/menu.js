import {request} from "../../request";

export function getMenu() {
  return request({
    url: "/admin/menu",
    method: "POST"
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
