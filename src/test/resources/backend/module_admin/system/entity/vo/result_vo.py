from pydantic import BaseModel, ConfigDict, Field
from pydantic.alias_generators import to_camel
from typing import Optional
from module_admin.annotation.pydantic_annotation import as_query




class ResultModel(BaseModel):
    """
    trade_result表对应pydantic模型
    """
    model_config = ConfigDict(alias_generator=to_camel, from_attributes=True)

    id: Optional[int] = Field(default=None, description='')
    project_code: Optional[str] = Field(default=None, description='')
    area: Optional[str] = Field(default=None, description='')
    project_type: Optional[str] = Field(default=None, description='')
    date_str: Optional[str] = Field(default=None, description='')
    project_name: Optional[str] = Field(default=None, description='')
    section_name: Optional[str] = Field(default=None, description='')
    winner: Optional[str] = Field(default=None, description='')
    price: Optional[str] = Field(default=None, description='')
    project_manager: Optional[str] = Field(default=None, description='')
    tender: Optional[str] = Field(default=None, description='')
    tender_linkman: Optional[str] = Field(default=None, description='')
    tender_linkman_call: Optional[str] = Field(default=None, description='')
    agency: Optional[str] = Field(default=None, description='')
    agency_linkman: Optional[str] = Field(default=None, description='')
    agency_linkman_call: Optional[str] = Field(default=None, description='')






class ResultQueryModel(ResultModel):
    """
    trade_result不分页查询模型
    """
    pass


@as_query
class ResultPageQueryModel(ResultQueryModel):
    """
    trade_result分页查询模型
    """

    page_num: int = Field(default=1, description='当前页码')
    page_size: int = Field(default=10, description='每页记录数')


class DeleteResultModel(BaseModel):
    """
    删除trade_result模型
    """

    model_config = ConfigDict(alias_generator=to_camel)

    ids: str = Field(description='需要删除的')
