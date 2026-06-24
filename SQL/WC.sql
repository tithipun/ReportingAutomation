SELECT SM.Style AS [SellStyle], SM.Workcenter, SM.WorkcenterCode, SM.Gender, SM.GarmentType, SM.Business, SM. FinancialGroup,SM.SAH
FROM ETL_STORE.dbo.STYLES AS SM
WHERE SM.Style LIKE 'MUT%'

SELECT *
FROM ETL_STORE.dbo.STYLES AS SM
where sm.[Style] in ('B74PP0','BRO2CR')

select *
From CPSMaster.dbo.StyleMaster sm 


--- SBU

SELECT vbsm.STYLE_NUM, vbsm.SBU_DESC 
FROM ETL_STORE.dbo.vBI_StyleMaster vbsm
where style_num = 'MHO101'

SELECT *
FROM ETL_STORE.dbo.STYLES AS SM

SELECT *
FROM CPSMaster.dbo.WorkcenterCodes wc 

SELECT 
    SM.*, 
    wc.MegaWorkcenterCode
FROM ETL_STORE.dbo.STYLES AS SM
JOIN CPSMaster.dbo.WorkcenterCodes AS wc
  ON SM.WorkcenterCode = wc.WorkcenterCode
where SM.style = '2252P6';

--- WC joing with MegaWC

SELECT 
    SM.[Style], 
    SM.WorkcenterCode,
    wc.MegaWorkcenterCode,
    SM.[FinancialSegment]
FROM ETL_STORE.dbo.STYLES AS SM
JOIN CPSMaster.dbo.WorkcenterCodes AS wc
  ON SM.WorkcenterCode = wc.WorkcenterCode
  --- WHERE SM.[Style] = '2252P6';

  
SELECT TOP 10 [FinancialSegment] 
FROM ETL_STORE.dbo.STYLES; 


SELECT *
FROM ETL_STORE.dbo.STYLES AS SM
where sm.[Style] = '2252Q5'


SQLP1BUS12\P1BUS12
ETL_STORE
select distinct STYLE_NUM, SBU_DESC from vBI_StyleMaster

select *
from dbo.CategoryCodes cc

select *
from PlaceHolderAttributionPercentage phap 