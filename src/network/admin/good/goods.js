import {request} from "../../../network/request";

export const pic_url = "http://localhost:8888/files/"

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

export function addGood(name, inPrice, outPrice, count, discount, categoryId, title, info, picName, weight, seafoodSource) {
  return request({
    url: "/admin/addSeafood",
    method: "POST",
    params: {
      name: name,
      inPrice: inPrice,
      outPrice: outPrice,
      count: count,
      discount: discount,
      categoryId: categoryId,
      title: title,
      info: info,
      picName: picName,
      weight: weight,
      seafoodSource: seafoodSource,
    }
  })
}

export function updateGood(id, name, inPrice, outPrice, count, discount, categoryId, title, info, picName, weight, seafoodSource) {
  return request({
    url: "/admin/updateSeafood",
    method: "POST",
    params: {
      id: id,
      name: name,
      inPrice: inPrice,
      outPrice: outPrice,
      count: count,
      discount: discount,
      categoryId: categoryId,
      title: title,
      info: info,
      picName: picName,
      weight: weight,
      seafoodSource: seafoodSource,
    }
  })
}

export function deleteSeafoodPic(id, name) {
  return request({
    url: "/admin/deleteSeafoodPic",
    method: "POST",
    params: {
      id: id,
      name: name,
    }
  })
}

export function deleteSeafood(id) {
  return request({
    url: '/admin/deleteSeafood',
    method: "POST",
    params: {
      id: id
    }
  })
}

export function getFireGood() {
  return request({
    url: '/admin/getFireGood',
    method: "POST",
  })
}

export function getAllGoods(name, lowPrice, highPrice, paixu, pageNo, pageSize) {
  return request({
    url: "/admin/getAllGoods",
    method: "POST",
    params: {
      name: name,
      highPrice: highPrice,
      lowPrice: lowPrice,
      paixu: paixu,
      pageNo: pageNo,
      pageSize: pageSize
    }
  })
}


export function getSearchGoods(keywords, paixu, categoryId) {
  return request({
    url: "/admin/getSearchGoods",
    method: "POST",
    params: {
      keywords: keywords,
      paixu: paixu,
      categoryId: categoryId
    }
  })
}

export function getSeafoodCount(id) {
  return request({
    url: "/admin/getSeafoodCount",
    method: "POST",
    params: {
      id
    }
  })
}

export function getSeafoodCountByList(seafoodList) {
  return request({
    url: "/admin/getSeafoodCountByList",
    method: "POST",
    params: {
      seafoodList
    }
  })
}

