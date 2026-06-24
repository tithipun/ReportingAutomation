'Conflicts'

SELECT DISTINCT 
    c.CONFLICT_PATH,
    c.CONFLICT_SKU,
    c.CONFLICT_REASON,
    c.QUANTITY,
    a.PLANNER_CODE,
    -- Changed from c.LOCATION to a.LOCATION (if that's where the column exists)
    a.LOCATION, 
    a.FAMILY,
    a.STYLE,
    a.COLOR,
    a.ATTRIBUTE,
    a.ORDER_SIZE,
    a.DEMAND_TYPE,
    a.ORDER_SOURCE_CD
FROM 
    plan_order_conflict c
INNER JOIN 
    plan_order_description a 
    ON a.order_version = c.order_version 
    AND a.order_label = c.order_label
WHERE 
    a.STYLE IN (
        SELECT DISTINCT d.SELLING_STYLE_CD
        FROM AVYX_DEMAND_DRIVER d
        LEFT JOIN (
            SELECT DISTINCT STYLE_CD, COLOR_CD, ATTRIBUTE_CD, SIZE_CD, ISS_IND
            FROM DA.MV_SKU
        ) b 
        ON d.SELLING_STYLE_CD = b.STYLE_CD 
        AND d.SELLING_COLOR_CD = b.COLOR_CD 
        AND d.SIZE_CD = b.SIZE_CD
    )
ORDER BY 
    c.CONFLICT_SKU ASC

    
--- Conflict query with condtion that no filter a.style exist in AVYX_DEMAND_DRIVER

SELECT
    c.CONFLICT_PATH,
    c.CONFLICT_SKU,
    c.CONFLICT_REASON,
    c.QUANTITY,
    a.PLANNER_CODE,
    a.LOCATION,
    a.FAMILY,
    a.STYLE,
    a.COLOR,
    a.ATTRIBUTE,
    a.ORDER_SIZE,
    a.DEMAND_TYPE,
    a.ORDER_SOURCE_CD
FROM
    plan_order_conflict c
INNER JOIN
    plan_order_description a
    ON a.order_version = c.order_version
    AND a.order_label = c.order_label
ORDER BY
    c.CONFLICT_SKU ASC

    
'Spillled Over'
    
SELECT 
  b.business_group_lvl_1, b.business_group_lvl_2, A.SEW_WORK_CENTER, cut_work_center, sew_routing, mfg_path_id, sew_plant,
  b.style_code, b.color_code, b.attribute_code, b.size_code, b.product_code, a.Super_Order,
  b.plant_cd, b.critical_ratio, A.SPILL_OVER_IND, SUM(b.current_qty) AS Current_Qty
  -- b.demand_sub_type,
FROM iss_prod_summary A
INNER JOIN DA.HBI_SEQUENCED_DEMAND B
ON a.priority = b.sequence_number
WHERE 
  SPILL_OVER_IND = 'Y' 
  AND b.critical_ratio <= 3 
  AND A.SELLING_STYLE_CD = b.style_code
  AND b.customer_ship_date < b.BENCH_MARK_DATE + 39*7 --AND style_code = 'GSMBA1'
GROUP BY 
  b.business_group_lvl_1, b.business_group_lvl_2, A.SEW_WORK_CENTER, cut_work_center, sew_routing, mfg_path_id, sew_plant,
  b.style_code, b.color_code, b.attribute_code, b.size_code, b.product_code, a.Super_Order,
  b.plant_cd, b.critical_ratio, A.SPILL_OVER_IND
ORDER BY product_code


'Spillled Over - Distinct'

SELECT DISTINCT
    b.style_code,
    b.color_code,
    A.Spill_Over_IND
FROM iss_prod_summary A
INNER JOIN DA.HBI_SEQUENCED_DEMAND B
    ON a.priority = b.sequence_number
WHERE 
    A.SPILL_OVER_IND = 'Y'  
    --- AND b.critical_ratio <= 3 
AND A.SELLING_STYLE_CD = b.style_code
    --- AND b.customer_ship_date < b.BENCH_MARK_DATE + 39*7
ORDER BY
    b.style_code,
    b.color_code;


   
---- Test   
   
SELECT 
    c.CONFLICT_PATH,
    c.CONFLICT_SKU,
    c.CONFLICT_REASON,
    c.QUANTITY,
    a.PLANNER_CODE,
    -- Changed from c.LOCATION to a.LOCATION (if that's where the column exists)
    a.LOCATION, 
    a.FAMILY,
    a.STYLE,
    a.COLOR,
    a.ATTRIBUTE,
    a.ORDER_SIZE,
    a.DEMAND_TYPE,
    a.ORDER_SOURCE_CD

SELECT *
FROM plan_order_conflict c

SELECT *
FROM plan_order_description
WHERE ORDER_Version = '20000001' AND order_label = 'K003295766'


SELECT * FROM AVYX_DEMAND_DRIVER 
WHERE STYLE = 'BX7B20'
WHERE SELLING_STYLE_CD = 'B74RR7'




