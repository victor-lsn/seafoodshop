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

export function getParentCategoryVo(){
  return request({
    url: "/admin/getParentCategoryVo",
    method: "POST",
  })
}

export function getCategoryById(id){
  return request({
    url: "/admin/getCategoryById",
    method: "POST",
    params: {
      id
    }
  })
}

export function updateCategory(categoty){
  return request({
    url: "/admin/updateCategory",
    method: "POST",
    params: categoty
  })
}
