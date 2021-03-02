import {request} from "../../../network/request";

export function getAllSeafood(name, lowPrice, highPrice, lowDate, highDate, category, pageNo, pageSize) {
  return request({
    url: "/admin/getAllSeafood",
    method: "POST",
    params: {
      name: name,
      highPrice: highPrice,
      lowPrice: lowPrice,
      lowDate: lowDate,
      highDate: highDate,
      category: category,
      pageNo: pageNo,
      pageSize: pageSize
    }
  })
}


export function getSeafoodById(id) {
  return request({
    url: "/admin/getSeafoodById",
    method: "POST",
    params: {
      id: id
    }
  })
}
