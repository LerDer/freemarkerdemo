import request from '@/utils/request'

// 查询trade_result列表
export function listResult(query) {
  return request({
    url: '/system/result/list',
    method: 'get',
    params: query
  })
}

// 查询trade_result详细
export function getResult(id) {
  return request({
    url: '/system/result/' + id,
    method: 'get'
  })
}

// 新增trade_result
export function addResult(data) {
  return request({
    url: '/system/result',
    method: 'post',
    data: data
  })
}

// 修改trade_result
export function updateResult(data) {
  return request({
    url: '/system/result',
    method: 'put',
    data: data
  })
}

// 删除trade_result
export function delResult(id) {
  return request({
    url: '/system/result/' + id,
    method: 'delete'
  })
}
