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