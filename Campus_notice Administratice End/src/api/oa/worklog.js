import request from '@/utils/requestoa'
export function fetchList(params) {
  return request({
    url:'/worklog/page',
    method:'get',
    params:params
  })
}

export function saveWorklog(data) { 
  return request({
    url:'/worklog/save',
    method:'post',
    data:data
  })
}
 

export function saveMaster(data) { 
  return request({
    url:'/worklog/saveMaster',
    method:'post',
    data:data
  })
}

export function delMaster(param) {  
  return request({
    url:'/worklog/delMaster',
    method:'get',
    params:param
  })
}
 

export function saveAll(data) { 
  return request({
    url:'/worklog/saveAll',
    method:'post',
    data:data
  })
}
 

export function saveWorklogDetail(data) {
  return request({
    url:'/worklog/saveDetail',
    method:'post',
    data:data
  })
}


export function getAllByid(param){
  return request({
    url:"/worklog/getAllByid",
    method:'get',
    params: param
  })
}
 