from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from config.constant import CommonConstant
from exceptions.exception import ServiceException
from module_admin.entity.vo.common_vo import CrudResponseModel
from module_admin.system.dao.result_dao import ResultDao
from module_admin.system.entity.vo.result_vo import DeleteResultModel, ResultModel, ResultPageQueryModel
from utils.common_util import CamelCaseUtil
from utils.excel_util import ExcelUtil


class ResultService:
    """
    trade_result模块服务层
    """

    @classmethod
    async def get_result_list_services(
        cls, query_db: AsyncSession, query_object: ResultPageQueryModel, is_page: bool = False
    ):
        """
        获取trade_result列表信息service

        :param query_db: orm对象
        :param query_object: 查询参数对象
        :param is_page: 是否开启分页
        :return: trade_result列表信息对象
        """
        result_list_result = await ResultDao.get_result_list(query_db, query_object, is_page)

        return result_list_result


    @classmethod
    async def add_result_services(cls, query_db: AsyncSession, page_object: ResultModel):
        """
        新增trade_result信息service

        :param query_db: orm对象
        :param page_object: 新增trade_result对象
        :return: 新增trade_result校验结果
        """
        try:
            await ResultDao.add_result_dao(query_db, page_object)
            await query_db.commit()
            return CrudResponseModel(is_success=True, message='新增成功')
        except Exception as e:
            await query_db.rollback()
            raise e

    @classmethod
    async def edit_result_services(cls, query_db: AsyncSession, page_object: ResultModel):
        """
        编辑trade_result信息service

        :param query_db: orm对象
        :param page_object: 编辑trade_result对象
        :return: 编辑trade_result校验结果
        """
        edit_result = page_object.model_dump(exclude_unset=True, exclude={})
        result_info = await cls.result_detail_services(query_db, page_object.id)
        if result_info.id:
            try:
                await ResultDao.edit_result_dao(query_db, edit_result)
                await query_db.commit()
                return CrudResponseModel(is_success=True, message='更新成功')
            except Exception as e:
                await query_db.rollback()
                raise e
        else:
            raise ServiceException(message='trade_result不存在')

    @classmethod
    async def delete_result_services(cls, query_db: AsyncSession, page_object: DeleteResultModel):
        """
        删除trade_result信息service

        :param query_db: orm对象
        :param page_object: 删除trade_result对象
        :return: 删除trade_result校验结果
        """
        if page_object.ids:
            id_list = page_object.ids.split(',')
            try:
                for id in id_list:
                    await ResultDao.delete_result_dao(query_db, ResultModel(id=id))
                await query_db.commit()
                return CrudResponseModel(is_success=True, message='删除成功')
            except Exception as e:
                await query_db.rollback()
                raise e
        else:
            raise ServiceException(message='传入为空')

    @classmethod
    async def result_detail_services(cls, query_db: AsyncSession, id: int):
        """
        获取trade_result详细信息service

        :param query_db: orm对象
        :param id: 
        :return: 对应的信息
        """
        result = await ResultDao.get_result_detail_by_id(query_db, id=id)
        if result:
            result = ResultModel(**CamelCaseUtil.transform_result(result))
        else:
            result = ResultModel(**dict())

        return result

    @staticmethod
    async def export_result_list_services(result_list: List):
        """
        导出trade_result信息service

        :param result_list: trade_result信息列表
        :return: trade_result信息对应excel的二进制数据
        """
        # 创建一个映射字典，将英文键映射到中文键
        mapping_dict = {
            'id': '',
            'projectCode': '',
            'area': '',
            'projectType': '',
            'dateStr': '',
            'projectName': '',
            'sectionName': '',
            'winner': '',
            'price': '',
            'projectManager': '',
            'tender': '',
            'tenderLinkman': '',
            'tenderLinkmanCall': '',
            'agency': '',
            'agencyLinkman': '',
            'agencyLinkmanCall': '',
        }
        binary_data = ExcelUtil.export_list2excel(result_list, mapping_dict)

        return binary_data
