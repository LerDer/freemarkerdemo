import request from '@/utils/request'

<#list fieldConfigs as field>
    <#if field.isPrimary>
        <#assign pkColumn = field>
    </#if>
</#list>

// 查询${businessName}列表
export function list${className}(query) {
		return request({
	url: '/${apiModuleName}/${apiName}/list',
			method: 'get',
			params: query
})
		}

// 查询 ${businessName}详细
export function get${className}(${pkColumn.fieldName}) {
		return request({
	url: '/${apiModuleName}/${apiName}/' + ${pkColumn.fieldName},
			method: 'get'
})
		}

// 新增${businessName}
export function add${className}(data) {
		return request({
	url: '/${apiModuleName}/${apiName}',
			method: 'post',
			data: data
})
		}

// 修改${businessName}
export function update${className}(data) {
		return request({
	url: '/${apiModuleName}/${apiName}',
			method: 'put',
			data: data
})
		}

// 删除${businessName}
export function del${className}(${pkColumn.fieldName}) {
		return request({
	url: '/${apiModuleName}/${apiName}/' + ${pkColumn.fieldName},
			method: 'delete'
})
		}
