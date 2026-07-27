import request from '@/utils/requestoa'



// 新增请假
export function addLeave(data) {
  return request({
    url: '/leave/save',
    method: 'post',
    data: data
  })
}

// 删除请假
export function delLeave(id) {
  return request({
    url: '/leave/deleteLeave/' + id,
    method: 'get'
  })
}
 

// 修改请假
export function updateLeave(data) {
  return request({
    url: '/leave/save',
    method: 'post',
    data: data
  })
}

// 查询请假列表
export function listLeave(query) {  
  return request({
    url: '/leave/page',
    method: 'get',
    params: query
  })
}

// 查询请假详细
// http://172.17.10.231:6060/leave/getLeaveById?id=3
export function getLeaveById(val) {
  return request({
    url: '/leave/getLeaveById',
    method: 'get',
    params: {
      id:val
    }
  })
}
 
// 查询请假类别
export function getDictDetailByDictId(val) {
  return request({
    url: 'sysDictDetail/getListByDictId',
    method: 'get',
    params:{
      dictId: val
    }
  })
}
 
