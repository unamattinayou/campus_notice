 import axios from 'axios' 
 
// 创建axios实例
const http = axios.create({
  baseURL: import.meta.env.VITE_BASE_SERVER_URL,
  timeout: 8080,
})
 
// axios请求拦截器
http.interceptors.request.use(
  config => {
    console.log('request: ', config);
    //从pinia获取token
    // const token = null
    // if (token) {
    //   config.headers.Authorization = token
    // }
    return config
  },
  e => Promise.reject(e),
)
 
// axios响应拦截器
http.interceptors.response.use(
  response => {
    console.log('response: ', response);
    const res = response.data
    if (res.code !== 200) {
      return Promise.reject(new Error(res.message || '请求失败'))
    } else {
      return response.data
    }
  },
  error => {
    // 全局处理异常请求
    console.log('error' + error)
    return Promise.reject(error)
  },
)
 
export default http