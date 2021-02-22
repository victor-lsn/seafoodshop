import axios from 'axios'
import router from '@/router'
import { MessageBox, Message } from 'element-ui'

export function request(config) {
  /*创建实例*/
  const instance1 = axios.create({
    timeout: 5000,
    baseURL:"http://127.0.0.1:9527"
  })

  /*请求拦截器*/
  instance1.interceptors.request.use(config => {
    console.log(config);
    config.headers.Authorization = window.localStorage.getItem("token");
    return config;
  }, error => {
    console.log(error);
  })

  /*响应拦截器*/
  instance1.interceptors.response.use(res => {
    console.log(res);
    return res;
  }, error => {
    //console.log(error.response);
    if (error.response.status == 401){
      router.push("/login");
      Message({ type: 'error', message: error.response.data.message});
    }
    if (error.response.status == 500){
      Message({ type: 'error', message: '服务器崩溃了'});
    }
  })


  return instance1(config);
}
