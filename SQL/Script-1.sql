
DESCRIBE DA.IBP_TOTAL_DEMAND_OUTPUT_CPS;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'IBP_TOTAL_DEMAND_OUTPUT_CPS';

SELECT column_name, data_type, nullable
FROM all_tab_columns
WHERE table_name = 'IBP_TOTAL_DEMAND_OUTPUT_CPS'
  AND owner = 'DA';

SELECT *  
FROM DA.IBP_TOTAL_DEMAND_OUTPUT_CPS

SELECT *
FROM da.INVENTORY_DAILY id nventory
