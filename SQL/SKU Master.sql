SELECT SKU.STYLE_CD, SKU.COLOR_CD, SKU.ATTRIBUTE_CD, SKU.SIZE_CD, SKU.ISS_IND
FROM DA.SKU SKU
Where SKU.STYLE_CD in ('DFMLBF','CFFMF3')
ORDER BY SKU.STYLE_CD, SKU.COLOR_CD, SKU.SIZE_CD

SELECT *
FROM DA.SKU SKU
Where SKU.STYLE_CD in ('MHG501','DF3W11') AND sku.ISS_IND = 'N'


SELECT *
FROM DA.SKU SKU
Where SKU.STYLE_CD in ('2349C4','7460P4','MKCBX5') AND COLOR_CD = '1GW'

SELECT *
FROM DA.STYLE STY
WHERE style_cd = 'J842TJ'

SELECT *
FROM DA.SKU_REVISION sr
WHERE style_cd like 'J842TJ%'

-- case master

SELECT SR.Style_CD, SR.Color_CD, SR.Size_CD, SR.STD_CASE_QTY
FROM DA.SKU_REVISION sr
WHERE style_cd LIKE 'DF%' 
OR style_cd LIKE 'DM%'
OR style_cd LIKE 'FLS%'
OR style_cd LIKE 'MBW%'
OR style_cd LIKE 'MBT%'
OR style_cd LIKE 'SES%'
OR style_cd LIKE 'SN%'
OR style_cd LIKE 'FP%'
OR style_cd LIKE 'W8%'
OR style_cd LIKE 'US%'

-- case master get highest rev

SELECT *
FROM (
    SELECT
        SR.Style_CD,
        SR.Color_CD,
        SR.Size_CD,
        SR.REVISION_NO,
        SR.CASES_PER_PALLET,
        SR.CARTON_ID,
        SR.STD_CASE_QTY,
        ROW_NUMBER() OVER (
            PARTITION BY SR.Style_CD, SR.Color_CD, SR.Size_CD
            ORDER BY SR.REVISION_NO DESC
        ) AS RN
    FROM DA.SKU_REVISION SR
) LatestRevisions  -- ✅ Subquery alias (no "AS" in Oracle)
WHERE RN = 1;


SELECT DISTINCT
    Style_CD,
    CARTON_ID,
    STD_CASE_QTY
FROM (
    SELECT
        SR.Style_CD,
        SR.CARTON_ID,
        SR.STD_CASE_QTY,
        ROW_NUMBER() OVER (
            PARTITION BY SR.Style_CD
            ORDER BY SR.REVISION_NO DESC
        ) AS RN
    FROM DA.SKU_REVISION SR
) LatestRevisions
WHERE RN = 1;



WHERE sr.STYLE_CD = 'NCBBP3'

SELECT s.STYLE_CD, s.CORP_PROD_FAMILY_CD
FROM DA."STYLE" s 
Where s.STYLE_CD in ('DFMLBF','2349z5')

-- Primary DC

SELECT * 
FROM DA.STYLE STY
WHERE primary_DC IN ('KM','KG','PW','3M') AND STYLE_CD = 'OC49AS'

SELECT * 
FROM DA.STYLE STY
WHERE primary_DC = 'PW'

SELECT s.STYLE_CD, s.PACK_CD
FROM da.STYLE s
WHERE s.PLAN_STATUS_CD = 'A' AND s.pack_CD <> 'X' AND s.STYLE_cd = '225209'


-- Case Dimension

SELECT *
FROM da.CASE_CARTON cc

ISS IND

SELECT *
FROM da.SKU s

SELECT 
    SKU.STYLE_CD, 
    SKU.COLOR_CD, 
    SKU.ATTRIBUTE_CD, 
    SKU.SIZE_CD, 
    SKU.ISS_IND, 
    SKU.PRIMARY_DC_REVISION_NO,
    SKU.EFFECT_END_DATE,
    SKU.CREATE_DATE,
    SKU.UPDATE_DATE 
FROM DA.SKU SKU
WHERE SKU.ISS_IND = 'N'
  AND SKU.PRIMARY_DC_REVISION_NO = '0'
  AND SKU.ATTRIBUTE_CD = '------'
  AND SKU.SIZE_CD IN (
        'NH','NI','NJ','NQ','NR','NS','NT','NU',
        'OB','OC','OD','OE','OF','ON','OO','OP','OQ','OR',
        'NG','NK',
        '7A','7B','7C','7D','7I','7J','7K',
        'NV','OG','OS','OZ',
        '41','42','43','44','45','46','40','00',
        '9W','6W','AZ','NB','NP','OA','OM','NA','NC','NF',
        '7E','7F','NW','OH','OT',
        '6D','6E','6F','6H',
        '7G','7H','7L',
        'NL','NM','NN','NX',
        'OI','OU','OV','OW',
        '32','33','34','35','06','07','08','09','36','05',
        '8K','8M','37','31',
        '5U','5V','5W','5X','5Y',
        '47','48','+E'
    )
ORDER BY 
    SKU.STYLE_CD, 
    SKU.COLOR_CD, 
    SKU.SIZE_CD;
    
   
--- Another one join GT
   
SELECT 
    S.STYLE_CD, 
    S.COLOR_CD, 
    S.ATTRIBUTE_CD, 
    S.SIZE_CD, 
    S.ISS_IND, 
    S.PRIMARY_DC_REVISION_NO,
    S.EFFECT_END_DATE,
    S.CREATE_DATE,
    S.UPDATE_DATE,
    H.BUSINESS_GROUP_LVL_1
FROM DA.SKU S

-- JOIN ONLY THE BUSINESS_GROUP_LVL_1 INFORMATION
INNER JOIN (
    SELECT 
        style_code,
        color_code,
        BUSINESS_GROUP_LVL_1
    FROM da.hbi_sequenced_demand@prod4.world
    WHERE BUSINESS_GROUP_LVL_1 IN (
        -- 'HANES AW PRINTWEAR',
        -- 'MEN''S UW',
        -- 'KID''S UW',
        -- 'POLO UW/SP',
        -- 'HANES APPAREL CONSUMER',
        'HANES WOMENS',
        'MAIDENFORM WOMENS',
        -- 'GLOBAL SUPPLY CHAIN',
        'BALI WOMENS',
        -- 'CANADA-AW',
        -- 'MASS BRANDS SA',
        'SCRUBS LOUNGEWEAR',
        'CANADA-IW',
        'PLAYTEX WOMENS',
        'OTHER WOMENS'
    )
) H
    ON S.STYLE_CD = H.STYLE_CODE
   AND S.COLOR_CD = H.COLOR_CODE

WHERE S.ISS_IND = 'N'
  AND S.PRIMARY_DC_REVISION_NO = '0'
  AND S.ATTRIBUTE_CD = '------'
  AND S.SIZE_CD IN (
        'NH','NI','NJ','NQ','NR','NS','NT','NU',
        'OB','OC','OD','OE','OF','ON','OO','OP','OQ','OR',
        'NG','NK',
        '7A','7B','7C','7D','7I','7J','7K',
        'NV','OG','OS','OZ',
        '41','42','43','44','45','46','40','00',
        '9W','6W','AZ','NB','NP','OA','OM','NA','NC','NF',
        '7E','7F','NW','OH','OT',
        '6D','6E','6F','6H',
        '7G','7H','7L',
        'NL','NM','NN','NX',
        'OI','OU','OV','OW',
        '32','33','34','35','06','07','08','09','36','05',
        '8K','8M','37','31',
        '5U','5V','5W','5X','5Y',
        '47','48','+E'
    )

ORDER BY 
    S.STYLE_CD, 
    S.COLOR_CD, 
    S.SIZE_CD;

   
---Keep only Selling
   
SELECT DISTINCT
    S.STYLE_CD, 
    S.ATTRIBUTE_CD,
    S.ISS_IND, 
    S.PRIMARY_DC_REVISION_NO,
    S.EFFECT_END_DATE,
    S.CREATE_DATE,
    S.UPDATE_DATE,
    H.BUSINESS_GROUP_LVL_1

FROM DA.SKU S

-- JOIN ONLY ON STYLE_CD
INNER JOIN (
    SELECT 
        style_code,
        BUSINESS_GROUP_LVL_1
    FROM da.hbi_sequenced_demand@prod4.world
    WHERE BUSINESS_GROUP_LVL_1 IN (
        'HANES WOMENS',
        'MAIDENFORM WOMENS',
        'BALI WOMENS',
        'SCRUBS LOUNGEWEAR',
        'CANADA-IW',
        'PLAYTEX WOMENS',
        'OTHER WOMENS'
    )
) H
    ON S.STYLE_CD = H.STYLE_CODE

WHERE S.ISS_IND = 'N'
  AND S.PRIMARY_DC_REVISION_NO = '0'
  AND S.ATTRIBUTE_CD = '------'

ORDER BY 
    S.STYLE_CD;
    
   
---Keep only Selling and Color
   
SELECT DISTINCT
    S.STYLE_CD,
    S.COLOR_CD,
    S.ATTRIBUTE_CD,
    S.ISS_IND,
    S.PLAN_STATUS_CD,
    H.BUSINESS_GROUP_LVL_1
FROM DA.SKU S

-- JOIN ON BOTH STYLE & COLOR
INNER JOIN (
    SELECT 
        style_code,
        color_code,
        BUSINESS_GROUP_LVL_1
    FROM da.hbi_sequenced_demand@prod4.world
    WHERE BUSINESS_GROUP_LVL_1 IN (
        'HANES WOMENS',
        'MAIDENFORM WOMENS',
        'BALI WOMENS',
        'SCRUBS LOUNGEWEAR',
        'CANADA-IW',
        'PLAYTEX WOMENS',
        'OTHER WOMENS'
    )
) H
    ON S.STYLE_CD = H.STYLE_CODE
   AND S.COLOR_CD = H.COLOR_CODE

--- WHERE 
    -- S.ISS_IND = 'N'
    -- S.PRIMARY_DC_REVISION_NO = '0'
    -- S.ATTRIBUTE_CD = '------'

ORDER BY 
    S.STYLE_CD,
    S.COLOR_CD;

---Keep only Selling and Color and no joing with HBI sequence demand

SELECT DISTINCT
    S.STYLE_CD,
    S.COLOR_CD,
    S.ATTRIBUTE_CD,
    S.ISS_IND,
    S.PLAN_STATUS_CD
FROM DA.SKU S

-- Optional filters (currently commented out)
WHERE 
-- S.ISS_IND = 'N'
S.PLAN_STATUS_CD = 'I'
--     AND S.PRIMARY_DC_REVISION_NO = '0'
--     AND S.ATTRIBUTE_CD = '------'

ORDER BY 
    S.STYLE_CD,
    S.COLOR_CD;

   