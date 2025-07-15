{% set pkField = pkColumn.python_field %}
{% set pk_field = pkColumn.python_field | camel_to_snake %}
{% for column in columns %}
{% if column.python_field == "createTime" %}
from datetime import datetime
{% endif %}
{% endfor %}
from fastapi import APIRouter, Depends, Form, Request
from pydantic_validation_decorator import ValidateFields
from sqlalchemy.ext.asyncio import AsyncSession
from config.enums import BusinessType
from config.get_db import get_db
from module_admin.annotation.log_annotation import Log
from module_admin.aspect.interface_auth import CheckUserInterfaceAuth
from module_admin.entity.vo.user_vo import CurrentUserModel
from module_admin.service.login_service import LoginService
from ${packageName}.${apiModuleName}.service.${apiName}_service import ${classNamePrefix}Service
from ${packageName}.${apiModuleName}.entity.vo.${apiName}_vo import Delete${classNamePrefix}Model, ${classNamePrefix}Model, ${classNamePrefix}PageQueryModel
from utils.common_util import bytes2file_response
from utils.log_util import logger
from utils.page_util import PageResponseModel
from utils.response_util import ResponseUtil

<#list fieldConfigs as field>
    <#if field.isPrimary>
        <#assign pkColumn = field>
    </#if>
</#list>

${apiName}Controller = APIRouter(prefix='/${apiModuleName}/${apiName}', dependencies=[Depends(LoginService.get_current_user)])


@${apiName}Controller.get(
    '/list', response_model=PageResponseModel, dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:list'))]
)
async def get_${apiModuleName}_${apiName}_list(
    request: Request,
    {% if table.crud or table.sub %}${apiName}_page_query{% elif table.tree %}${apiName}_query{% endif %}: ${classNamePrefix}PageQueryModel = Depends(${classNamePrefix}PageQueryModel.as_query),
    query_db: AsyncSession = Depends(get_db),
):
    {% if table.crud or table.sub %}
    # 获取分页数据
    ${apiName}_page_query_result = await ${classNamePrefix}Service.get_${apiName}_list_services(query_db, ${apiName}_page_query, is_page=True)
    logger.info('获取成功')

    return ResponseUtil.success(model_content=${apiName}_page_query_result)
    {% elif table.tree %}
    ${apiName}_query_result = await ${classNamePrefix}Service.get_${apiName}_list_services(query_db, ${apiName}_query)
    logger.info('获取成功')

    return ResponseUtil.success(data=${apiName}_query_result)
    {% endif %}


@${apiName}Controller.post('', dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:add'))])
@ValidateFields(validate_model='add_${apiName}')
@Log(title='${tableName}', business_type=BusinessType.INSERT)
async def add_${apiModuleName}_${apiName}(
    request: Request,
    add_${apiName}: ${classNamePrefix}Model,
    query_db: AsyncSession = Depends(get_db),
    current_user: CurrentUserModel = Depends(LoginService.get_current_user),
):
    {% for column in columns %}
    {% if column.python_field == "createBy" %}
    add_${apiName}.create_by = current_user.user.user_name
    {% elif column.python_field == "createTime" %}
    add_${apiName}.create_time = datetime.now()
    {% elif column.python_field == "updateBy" %}
    add_${apiName}.update_by = current_user.user.user_name
    {% elif column.python_field == "updateTime" %}
    add_${apiName}.update_time = datetime.now()
    {% endif %}
    {% endfor %}
    add_${apiName}_result = await ${classNamePrefix}Service.add_${apiName}_services(query_db, add_${apiName})
    logger.info(add_${apiName}_result.message)

    return ResponseUtil.success(msg=add_${apiName}_result.message)


@${apiName}Controller.put('', dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:edit'))])
@ValidateFields(validate_model='edit_${apiName}')
@Log(title='${tableName}', business_type=BusinessType.UPDATE)
async def edit_${apiModuleName}_${apiName}(
    request: Request,
    edit_${apiName}: ${classNamePrefix}Model,
    query_db: AsyncSession = Depends(get_db),
    current_user: CurrentUserModel = Depends(LoginService.get_current_user),
):
    edit_${apiName}.update_by = current_user.user.user_name
    edit_${apiName}.update_time = datetime.now()
    edit_${apiName}_result = await ${classNamePrefix}Service.edit_${apiName}_services(query_db, edit_${apiName})
    logger.info(edit_${apiName}_result.message)

    return ResponseUtil.success(msg=edit_${apiName}_result.message)


@${apiName}Controller.delete('/{${pkColumn.fieldName!}s}', dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:remove'))])
@Log(title='${tableName}', business_type=BusinessType.DELETE)
async def delete_${apiModuleName}_${apiName}(request: Request, ${pkColumn.fieldName!}s: str, query_db: AsyncSession = Depends(get_db)):
    delete_${apiName} = Delete${classNamePrefix}Model(${pkColumn.fieldName!}s=${pkColumn.fieldName!}s)
    delete_${apiName}_result = await ${classNamePrefix}Service.delete_${apiName}_services(query_db, delete_${apiName})
    logger.info(delete_${apiName}_result.message)

    return ResponseUtil.success(msg=delete_${apiName}_result.message)


@${apiName}Controller.get(
    '/{${pkColumn.fieldName!}}', response_model=${classNamePrefix}Model, dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:query'))]
)
async def query_detail_${apiModuleName}_${apiName}(request: Request, ${pkColumn.fieldName!}: int, query_db: AsyncSession = Depends(get_db)):
    ${apiName}_detail_result = await ${classNamePrefix}Service.${apiName}_detail_services(query_db, ${pkColumn.fieldName!})
    logger.info(f'获取${pkColumn.fieldName!}为{${pkColumn.fieldName!}}的信息成功')

    return ResponseUtil.success(data=${apiName}_detail_result)


@${apiName}Controller.post('/export', dependencies=[Depends(CheckUserInterfaceAuth('${permissionPrefix}:export'))])
@Log(title='${tableName}', business_type=BusinessType.EXPORT)
async def export_${apiModuleName}_${apiName}_list(
    request: Request,
    ${apiName}_page_query: ${classNamePrefix}PageQueryModel = Form(),
    query_db: AsyncSession = Depends(get_db),
):
    # 获取全量数据
    ${apiName}_query_result = await ${classNamePrefix}Service.get_${apiName}_list_services(query_db, ${apiName}_page_query, is_page=False)
    ${apiName}_export_result = await ${classNamePrefix}Service.export_${apiName}_list_services({% if dicts %}request, {% endif %}${apiName}_query_result)
    logger.info('导出成功')

    return ResponseUtil.streaming(data=bytes2file_response(${apiName}_export_result))
