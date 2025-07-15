from sqlalchemy import delete, select, update
from sqlalchemy.ext.asyncio import AsyncSession
from module_admin.system.entity.do.result_do import TradeResult
from module_admin.system.entity.vo.result_vo import ResultModel, ResultPageQueryModel
from utils.page_util import PageUtil


class ResultDao:
    """
    trade_result模块数据库操作层
    """

    @classmethod
    async def get_result_detail_by_id(cls, db: AsyncSession, id: int):
        """
        根据获取trade_result详细信息

        :param db: orm对象
        :param id: 
        :return: trade_result信息对象
        """
        result_info = (
            (
                await db.execute(
                    select(TradeResult)
                    .where(
                        TradeResult.id == id
                    )
                )
            )
            .scalars()
            .first()
        )

        return result_info

    @classmethod
    async def get_result_detail_by_info(cls, db: AsyncSession, result: ResultModel):
        """
        根据trade_result参数获取trade_result信息

        :param db: orm对象
        :param result: trade_result参数对象
        :return: trade_result信息对象
        """
        result_info = (
            (
                await db.execute(
                    select(TradeResult).where(
                    )
                )
            )
            .scalars()
            .first()
        )

        return result_info

    @classmethod
    async def get_result_list(cls, db: AsyncSession, query_object: ResultPageQueryModel, is_page: bool = False):
        """
        根据查询参数获取trade_result列表信息

        :param db: orm对象
        :param query_object: 查询参数对象
        :param is_page: 是否开启分页
        :return: trade_result列表信息对象
        """
        query = (
            select(TradeResult)
            .where(
                TradeResult.project_code == query_object.project_code if query_object.project_code else True,
                TradeResult.area == query_object.area if query_object.area else True,
                TradeResult.project_type == query_object.project_type if query_object.project_type else True,
                TradeResult.date_str == query_object.date_str if query_object.date_str else True,
                TradeResult.project_name.like(f'%{query_object.project_name}%') if query_object.project_name else True,
                TradeResult.section_name.like(f'%{query_object.section_name}%') if query_object.section_name else True,
                TradeResult.winner == query_object.winner if query_object.winner else True,
                TradeResult.price == query_object.price if query_object.price else True,
                TradeResult.project_manager == query_object.project_manager if query_object.project_manager else True,
                TradeResult.tender == query_object.tender if query_object.tender else True,
                TradeResult.tender_linkman == query_object.tender_linkman if query_object.tender_linkman else True,
                TradeResult.tender_linkman_call == query_object.tender_linkman_call if query_object.tender_linkman_call else True,
                TradeResult.agency == query_object.agency if query_object.agency else True,
                TradeResult.agency_linkman == query_object.agency_linkman if query_object.agency_linkman else True,
                TradeResult.agency_linkman_call == query_object.agency_linkman_call if query_object.agency_linkman_call else True,
            )
            .order_by(TradeResult.id)
            .distinct()
        )
        result_list = await PageUtil.paginate(db, query, query_object.page_num, query_object.page_size, is_page)

        return result_list

    @classmethod
    async def add_result_dao(cls, db: AsyncSession, result: ResultModel):
        """
        新增trade_result数据库操作

        :param db: orm对象
        :param result: trade_result对象
        :return:
        """
        db_result = TradeResult(**result.model_dump(exclude={}))
        db.add(db_result)
        await db.flush()

        return db_result

    @classmethod
    async def edit_result_dao(cls, db: AsyncSession, result: dict):
        """
        编辑trade_result数据库操作

        :param db: orm对象
        :param result: 需要更新的trade_result字典
        :return:
        """
        await db.execute(update(TradeResult), [result])

    @classmethod
    async def delete_result_dao(cls, db: AsyncSession, result: ResultModel):
        """
        删除trade_result数据库操作

        :param db: orm对象
        :param result: trade_result对象
        :return:
        """
        await db.execute(delete(TradeResult).where(TradeResult.id.in_([result.id])))

