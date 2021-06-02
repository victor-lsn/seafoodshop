import {request} from "../../request";

export function addOrder1(userId, seafoodId, addrId, cost, pay) {
  return request({
    url: "/admin/addOrder1",
    method: "POST",
    params: {
      userId,
      seafoodId,
      addrId,
      cost,
      pay
    }
  })
}

export function addOrder2(userId, seafoodList, addrId, pay) {
  return request({
    url: "/admin/addOrder2",
    method: "POST",
    params: {
      userId,
      seafoodList,
      addrId,
      pay
    }
  })
}

export function getAllOrder(serialNumber, lowDate, highDate, pageNo, pageSize, status) {
  return request({
    url: "/admin/getAllOrder",
    method: "POST",
    params: {
      serialNumber,
      lowDate,
      highDate,
      pageNo,
      pageSize,
      status
    }
  })
}

export function getOrderByUser(userId) {
  return request({
    url: "/admin/getOrderByUser",
    method: "POST",
    params: {
      userId
    }
  })
}

export function updateOrder(orderId) {
  return request({
    url: "/admin/updateOrderStatus",
    method: "POST",
    params: {
      orderId
    }
  })
}

export function pay(name, info, userId, seafoodId, addrId) {
  return request({
    url: "/admin/toPay",
    method: "POST",
    params: {
      name, info, userId, seafoodId, addrId
    }
  })
}

export function pay2(name, info, userId, seafoodList, addrId,pay) {
  return request({
    url: "/admin/toPay2",
    method: "POST",
    params: {
      name, info, userId, seafoodList, addrId,pay
    }
  })
}
