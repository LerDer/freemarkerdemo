from fastapi import APIRouter, Depends, Form, Request
from pydantic_validation_decorator import ValidateFields
from sqlalchemy.ext.asyncio import AsyncSession
from config.enums import BusinessType
from config.get_db import get_db
from module_admin.annotation.log_annotation import Log
from module_admin.aspect.interface_auth import CheckUserInterfaceAuth
from module_admin.entity.vo.user_vo import CurrentUserModel
from module_admin.service.login_service import LoginService
from module_admin.system.service.result_service import ResultService
from module_admin.system.entity.vo.result_vo import DeleteResultModel, ResultModel, ResultPageQueryModel
from utils.common_util import bytes2file_response
from utils.log_util import logger
from utils.page_util import PageResponseModel
from utils.response_util import ResponseUtil


resultController = APIRouter(prefix='/system/result', dependencies=[Depends(LoginService.get_current_user)])


@resultController.get(
    '/list', response_model=PageResponseModel, dependencies=[Depends(CheckUserInterfaceAuth('system:result:list'))]
)
async def get_system_result_list(
    request: Request,
result_page_query: ResultPageQueryModel = Depends(ResultPageQueryModel.as_query),
    query_db: AsyncSession = Depends(get_db),
):
    # 获取分页数据
    result_page_query_result = await ResultService.get_result_list_services(query_db, result_page_query, is_page=True)
    logger.info('获取成功')

    return ResponseUtil.success(model_content=result_page_query_result)


@resultController.post('', dependencies=[Depends(CheckUserInterfaceAuth('system:result:add'))])
@ValidateFields(validate_model='add_result')
@Log(title='trade_result', business_type=BusinessType.INSERT)
async def add_system_result(
    request: Request,
    add_result: ResultModel,
    query_db: AsyncSession = Depends(get_db),
    current_user: CurrentUserModel = Depends(LoginService.get_current_user),
):
    add_result_result = await ResultService.add_result_services(query_db, add_result)
    logger.info(add_result_result.message)

    return ResponseUtil.success(msg=add_result_result.message)


@resultController.put('', dependencies=[Depends(CheckUserInterfaceAuth('system:result:edit'))])
@ValidateFields(validate_model='edit_result')
@Log(title='trade_result', business_type=BusinessType.UPDATE)
async def edit_system_result(
    request: Request,
    edit_result: ResultModel,
    query_db: AsyncSession = Depends(get_db),
    current_user: CurrentUserModel = Depends(LoginService.get_current_user),
):
    edit_result.update_by = current_user.user.user_name
    edit_result.update_time = datetime.now()
    edit_result_result = await ResultService.edit_result_services(query_db, edit_result)
    logger.info(edit_result_result.message)

    return ResponseUtil.success(msg=edit_result_result.message)


@resultController.delete('/{ids}', dependencies=[Depends(CheckUserInterfaceAuth('system:result:remove'))])
@Log(title='trade_result', business_type=BusinessType.DELETE)
async def delete_system_result(request: Request, ids: str, query_db: AsyncSession = Depends(get_db)):
    delete_result = DeleteResultModel(ids=ids)
    delete_result_result = await ResultService.delete_result_services(query_db, delete_result)
    logger.info(delete_result_result.message)

    return ResponseUtil.success(msg=delete_result_result.message)


@resultController.get(
    '/{id}', response_model=ResultModel, dependencies=[Depends(CheckUserInterfaceAuth('system:result:query'))]
)
async def query_detail_system_result(request: Request, id: int, query_db: AsyncSession = Depends(get_db)):
    result_detail_result = await ResultService.result_detail_services(query_db, id)
    logger.info(f'获取id为{id}的信息成功')

    return ResponseUtil.success(data=result_detail_result)


@resultController.post('/export', dependencies=[Depends(CheckUserInterfaceAuth('system:result:export'))])
@Log(title='trade_result', business_type=BusinessType.EXPORT)
async def export_system_result_list(
    request: Request,
    result_page_query: ResultPageQueryModel = Form(),
    query_db: AsyncSession = Depends(get_db),
):
    # 获取全量数据
    result_query_result = await ResultService.get_result_list_services(query_db, result_page_query, is_page=False)
    result_export_result = await ResultService.export_result_list_services(result_query_result)
    logger.info('导出成功')

    return ResponseUtil.streaming(data=bytes2file_response(result_export_result))
