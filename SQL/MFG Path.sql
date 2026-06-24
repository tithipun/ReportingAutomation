SELECT M.STYLE_CD, M.COLOR_CD, M.ATTRIBUTE_CD, M.SIZE_CD, M.MFG_PATH_ID, M.REVISION_NO, M.ORDER_MINIMUM, M.A_ITEM_ORD_INCR
FROM DA.MFG_PATH_CHP M
WHERE M.MFG_PATH_ID = '95'
ORDER BY M.STYLE_CD, M.COLOR_CD, M.SIZE_CD

SELECT M.STYLE_CD, M.COLOR_CD, M.ATTRIBUTE_CD, M.SIZE_CD, M.MFG_PATH_ID, M.Lead_time, M.PLANNING_TM_FNC 
FROM DA.MFG_PATH_CHP M

SELECT *
FROM DA.MFG_PATH_CHP M
WHERE style_cd = 'B74P1O' AND ATTRIBUTE_CD IN ('DYEIRY','DYEZ9F','DYE4PI','DYE4QI','DYE4RI') AND MFG_PATH_ID = '98' ('90','93','95') color_cd = '1NJ' AND PLANNER_CD = 'JFINT'

SELECT *
FROM DA.MFG_PATH_CHP M
WHERE style_cd IN ('B74P10','PRUB78') AND ATTRIBUTE_CD IN ('DYEIRY','DYEZ9F','DYE4PI','DYE4QI','DYE4RI')

SELECT *
FROM DA.MFG_PATH mp
WHERE style_cd = 'JE5719' AND ATTRIBUTE_CD = 'DYEZCA' AND CORP_STD_PATH_IND = 'Y' AND color_cd = '1NJ' AND mfg_path_ID in ('93','PW') AND size_cd
'MP.REVISION_NO = '999'

STYLE_CD in ('B74P10','2252P6'),
MFG_PATH_ID IN ('90','91')

SELECT * 
FROM "OPRSQL"."MFG_SELL_ASRMT_SKU_XREF_VIEW" S
where s.selling_style_cd in ('DF3380','DF3385') and s.color_cd = '1NJ'
WHERE S.MFG_PATH_ID in ('90','91','23','UA')

SELECT * 
FROM "OPRSQL"."MFG_SELL_ASRMT_SKU_XREF_VIEW" S
where s.selling_style_cd = 'DF3380' and s.color_cd = '1NJ'
WHERE S.MFG_PATH_ID in ('90','91','23','UA')

SELECT *
FROM DA.MFG_PATH mp
where style_cd in ('2349C4','7460P4','MKCBX5') and size_cD in ('45','46')
WHERE CORP_STD_PATH_IND = 'Y'

SELECT mp.*
FROM DA.MFG_PATH mp
INNER JOIN (
    SELECT style_cd, size_cd, MAX(revision_no) AS max_revision_no
    FROM DA.MFG_PATH
    WHERE style_cd IN ('2349C4', '7460P4', 'MKCBX5')
      AND revision_no NOT IN (915, 99)
    GROUP BY style_cd, size_cd
) latest
    ON  mp.style_cd      = latest.style_cd
    AND mp.size_cd       = latest.size_cd
    AND mp.revision_no   = latest.max_revision_no
WHERE mp.style_cd IN ('2349C4', '7460P4', 'MKCBX5')
ORDER BY mp.style_cd, mp.size_cd

--- Test

SELECT 
    mp.STYLE_CD, 
    mp.COLOR_CD, 
    mp.SIZE_CD,
	mp.MFG_Path_ID, 
    mp.CORP_STD_PATH_IND,
	C.Corp_division_CD
FROM DA.MFG_PATH mp
JOIN DA.STYLE s
    ON mp.STYLE_CD = s.STYLE_CD
JOIN CORP_DIVISION c
    ON s.CORP_DIVISION_CD = c.CORP_DIVISION_CD
WHERE mp.CORP_STD_PATH_IND = 'Y' and c.corp_division_CD in ('S1','SK','SO') and mp.style_cd = 'TBAK10'


SELECT *
FROM corp_division

SELECT *
FROM style s
where s.style_cd = 'D213'


Select *
from da.MFG_PATH
where style_CD = 'PHG521'

select *
From da.Rou


SELECT *
FROM DA.MFG_PATH_CHP M
WHERE STYLE_CD = 'MHG521' and Attribute_CD = 'DYEWAX' and size_CD '3O'

SELECT *
FROM da.ACTIVITY a

SELECT *
from da.planning_leadtime PL
where location_cd = 'BY'

Select *
From activity_Routing
where routing_ID = 'SOURCED          BY'


SELECT *
FROM DA.MFG_PATH mp
WHERE style_cd = 'RB2AT1'

select *
From Da.bill_OF_MTRLS
where parent_style = 'PHG521' 
 
select *
From Da.bill_OF_MTRLS
where parent_style in ('NBG52A','NBGP21') 
