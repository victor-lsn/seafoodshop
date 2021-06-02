import {request} from "../../../network/request";

export const pic_url = "http://localhost:8888/files/"

export function getAllAdvert(){
  return request({
    url:'/admin/getAllAdvert',
    method:"POST",
  })
}
