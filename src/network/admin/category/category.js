import {request} from "../../request";
import ca from "element-ui/src/locale/lang/ca";

export function getAllCategory() {
  return request({
    url: "/admin/getAllCategory",
    method: "POST",
  })
}

export function addCategory(name, desc, parent) {
  return request({
    url: "/admin/addCategory",
    method: "POST",
    params: {
      name: name,
      desc: desc,
      parent: parent
    }
  })
}

export function deleteCategory(categoryId) {
  return request({
    url: "/admin/deleteCategory",
    method: "POST",
    params: {
      categoryId: categoryId
    }
  })
}
