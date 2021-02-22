import {request} from "../../request";

export function getMenu() {
  return request({
    url: "/admin/menu",
    method: "POST"
  })
}
