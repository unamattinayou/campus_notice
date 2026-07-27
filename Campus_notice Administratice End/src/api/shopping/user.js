import http from '@/utils/request.ts'

// 查询用户列表
export function listUser(query) {
  return http({
    url: '/api/user/list',
    method: 'get',
    params: query
  })
}

// 查询用户详细
export function getUser(userId) {
  return http({
    url: '/api/user/' + userId,
    method: 'get'
  })
}

// 新增用户
export function addUser(data) {
  return http({
    url: '/api/user',
    method: 'post',
    data: data
  })
}

// 修改用户
export function updateUser(data) {
  return http({
    url: '/api/user',
    method: 'put',
    data: data
  })
}

// 删除用户
export function delUser(userId) {
  return http({
    url: '/api/user/' + userId,
    method: 'delete'
  })
}
