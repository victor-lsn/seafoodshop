import {request} from "../request";

export function login(phone, password, code) {
  return request({
    url: "/user/login",
    params: {
      phone: phone,
      password: password,
      code: code
    },
    method: "POST"
  })
}

export function register(name, phone, password, code) {
  return request({
    url: "/user/register",
    params: {
      name: name,
      phone: phone,
      password: password,
      code: code
    },
    method: "POST"
  })
}
