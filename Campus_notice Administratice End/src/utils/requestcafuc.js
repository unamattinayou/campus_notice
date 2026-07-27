import axios from 'axios'
 

axios.defaults.headers['Content-Type'] = 'application/json;charset=utf-8'
// 创建axios实例
const http = axios.create({
  // axios中请求配置有baseURL选项，表示请求URL公共部分
  baseURL: '/capi',
  // 超时
  timeout: 5000
})

// request拦截器
http.interceptors.request.use(config => {
  // console.log('config: ', config);

   
  return config
}, error => {
    console.log(error)
    Promise.reject(error)
})

// 响应拦截器
http.interceptors.response.use(res => {
  console.log('res: ', res);
    
      return  Promise.resolve(res.data)
 
  },
  error => {
    console.log('err' + error)
    return Promise.reject(error)
  }
)


export default http