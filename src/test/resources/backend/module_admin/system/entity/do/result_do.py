from sqlalchemy import Column, String, 
from config.database import Base


class TradeResult(Base):
    """
    trade_result表
    """

    __tablename__ = 'trade_result'

    id = Column(, primary_key=True, autoincrement=True, nullable=False, comment='')
    project_code = Column(String(80), nullable=True, comment='')
    area = Column(String(80), nullable=True, comment='')
    project_type = Column(String(40), nullable=True, comment='')
    date_str = Column(String(40), nullable=True, comment='')
    project_name = Column(String(200), nullable=True, comment='')
    section_name = Column(String(200), nullable=True, comment='')
    winner = Column(String(200), nullable=True, comment='')
    price = Column(String(20), nullable=True, comment='')
    project_manager = Column(String(80), nullable=True, comment='')
    tender = Column(String(100), nullable=True, comment='')
    tender_linkman = Column(String(80), nullable=True, comment='')
    tender_linkman_call = Column(String(20), nullable=True, comment='')
    agency = Column(String(200), nullable=True, comment='')
    agency_linkman = Column(String(80), nullable=True, comment='')
    agency_linkman_call = Column(String(20), nullable=True, comment='')



