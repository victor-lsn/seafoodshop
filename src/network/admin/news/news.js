import {request} from "../../request";

export function getAllNews(lowDate, highDate, pageNo, pageSize) {
  return request({
    url: "/admin/getAllNews",
    method: "POST",
    params: {
      lowDate,
      highDate,
      pageNo,
      pageSize
    }
  })
}

export function deleteNews(id) {
  return request({
    url: "/admin/deleteNews",
    method: "POST",
    params: {
      id
    }
  })
}

export function updateNews(id, content) {
  return request({
    url: "/admin/updateNews",
    method: "POST",
    params: {
      id,
      content
    }
  })
}

export function addNews(content) {
  return request({
    url: "/admin/addNews",
    method: "POST",
    params: {
      content
    }
  })
}
