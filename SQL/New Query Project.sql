SELECT distinct sku.style_CD, sku.color_CD, sku.MFG_revision_No
FROM DA.SKU sku


--- Check DB Link
SELECT owner, db_link, username, host, created
FROM dba_db_links
ORDER BY owner, db_link;


--- Step 1: Get SKU and revision (Highest Rev) from SKU table and check against IBP gross demand

SELECT DISTINCT
    sku.style_cd,
    sku.color_cd,
    sku.MFG_revision_No
FROM DA.SKU sku
INNER JOIN (
    SELECT DISTINCT
        hsd.style_code,
        hsd.color_code
    FROM da.HBI_SEQUENCED_DEMAND@PROD4.WORLD hsd
) h
    ON sku.style_cd = h.style_code
   AND sku.color_cd = h.color_code;

--- Step 2: add GT info Business level 1 from HSD  

  SELECT DISTINCT
    sku.style_cd,
    sku.color_cd,
    sku.MFG_revision_No,
    h.Business_Group_LVL_1
FROM DA.SKU sku
INNER JOIN (
    SELECT DISTINCT
        hsd.style_code,
        hsd.color_code,
        hsd.Business_Group_LVL_1
    FROM da.HBI_SEQUENCED_DEMAND@PROD4.WORLD hsd
) h
    ON sku.style_cd = h.style_code
   AND sku.color_cd = h.color_code;

--- Step 3: Join with OPRSQL to get packaging style and run only first 10

SELECT *
FROM (
    SELECT DISTINCT
        sku.style_cd,
        sku.color_cd,
        sku.MFG_revision_No,
        h.Business_Group_LVL_1,
        xref.MFG_STYLE_CD
    FROM DA.SKU sku
    INNER JOIN (
        SELECT DISTINCT
            hsd.style_code,
            hsd.color_code,
            hsd.Business_Group_LVL_1
        FROM da.HBI_SEQUENCED_DEMAND@PROD4.WORLD hsd
    ) h
        ON sku.style_cd = h.style_code
       AND sku.color_cd = h.color_code
    LEFT JOIN OPRSQL.MFG_SELL_ASRMT_SKU_XREF_VIEW xref
        ON sku.style_cd = xref.Selling_Style_CD
       AND sku.color_cd = xref.Selling_Color_CD
       AND sku.MFG_revision_No = xref.MFG_Revision_No
)
WHERE ROWNUM <= 10;

--- Run full put where clause for bisiness LV
--- LV1

SELECT DISTINCT
       sku.style_cd,
       sku.color_cd,
       sku.mfg_revision_no,
       h.BUSINESS_GROUP_LVL_1,
       xref.mfg_style_cd
FROM da.sku sku
INNER JOIN (
       SELECT
              style_code,
              color_code,
              BUSINESS_GROUP_LVL_1
       FROM da.hbi_sequenced_demand@prod4.world
       WHERE BUSINESS_GROUP_LVL_1 IN (
    'HANES AW PRINTWEAR',
    'MEN\'S UW',
    'KID\'S UW',
    'POLO UW/SP',
    'HANES APPAREL CONSUMER',
    'HANES WOMENS',
    'MAIDENFORM WOMENS',
    'GLOBAL SUPPLY CHAIN',
    'BALI WOMENS',
    'CANADA-AW',
    'MASS BRANDS SA',
    'SCRUBS LOUNGEWEAR',
    'CANADA-IW',
    'PLAYTEX WOMENS',
    'OTHER WOMENS'
    )
) h
       ON sku.style_cd = h.style_code
      AND sku.color_cd = h.color_code
LEFT JOIN oprsql.mfg_sell_asrmt_sku_xref_view xref
       ON sku.style_cd = xref.selling_style_cd
      AND sku.color_cd = xref.selling_color_cd
      AND sku.mfg_revision_no = xref.mfg_revision_no;

--- Run full put where clause for bisiness LV
--- LV2

SELECT DISTINCT
       sku.style_cd,
       sku.color_cd,
       sku.mfg_revision_no,
       h.BUSINESS_GROUP_LVL_2,
       xref.mfg_style_cd
FROM da.sku sku
INNER JOIN (
       SELECT
              style_code,
              color_code,
              BUSINESS_GROUP_LVL_2
       FROM da.hbi_sequenced_demand@prod4.world
       WHERE BUSINESS_GROUP_LVL_2 IN (
              'BALI SHAPE CUT-SEW SOURCED',
              'CAN SHAPE SEAMLESS SOURCED',
              'PLAYTEX WOMENS PANTY SOURCED',
              'BALI SHAPE SEAMLESS SOURCED',
              'CW SOURCED ZIPHOOD',
              'CW SOURCED TOP',
              'MAIDEN_F WOMENS PANTY SOURCED',
              'CW SOURCED HOOD',
              'CAN BASICS SOURCED',
              'MAIDEN_F BRA CUT-SEW SOURCED',
              'MAIDEN_F BRA SEAMLESS SOURCED',
              'PLAYTEX BRA CUT-SEW SOURCED',
              'PW SOURCED TOP',
              'HANES WOMENS PANTY SOURCED',
              'BALI WOMENS PANTY SOURCED',
              'PLAYTEX BRA SEAMLESS SOURCED',
              'HANES BRA CUT-SEW SOURCED',
              'CAN SHAPE CUT-SEW SOURCED',
              'CAN BRA SEAMLESS SOURCED',
              'CW SOURCED BOTTOM',
              'CAN INTIMATES PANTY SOURCED',
              'BALI BRA CUT-SEW SOURCED',
              'CAN BRA CUT-SEW SOURCED',
              'BALI SLEEPWEAR SOURCED',
              'BALI BRA SEAMLESS SOURCED',
              'MAIDEN_F SHP SEAMLESS SOURCED'
       )
) h
       ON sku.style_cd = h.style_code
      AND sku.color_cd = h.color_code
LEFT JOIN oprsql.mfg_sell_asrmt_sku_xref_view xref
       ON sku.style_cd = xref.selling_style_cd
      AND sku.color_cd = xref.selling_color_cd
      AND sku.mfg_revision_no = xref.mfg_revision_no;


-- check if GT is in or not     
SELECT COUNT(*)
FROM da.hbi_sequenced_demand@prod4.world
WHERE business_group_lvl_1 = 'MAIDENFORM WOMENS';

--- List
BUSINESS_GROUP_LVL_1
HANES AW PRINTWEAR
MEN'S UW
KID'S UW
POLO UW/SP
HANES APPAREL CONSUMER
HANES WOMENS
MAIDENFORM WOMENS
GLOBAL SUPPLY CHAIN
BALI WOMENS
CANADA-AW
MASS BRANDS SA
SCRUBS LOUNGEWEAR
CANADA-IW
PLAYTEX WOMENS
OTHER WOMENS


SELECT S.* 
FROM "OPRSQL"."MFG_SELL_ASRMT_SKU_XREF_VIEW" S
WHERE SELLING_STYLE_CD = '09417' 

-- latest revsion from SKU table and join with MFG path to get MFG path ID

SELECT DISTINCT
       lr.Style_CD,
       mp.MFG_PATH_ID
FROM (
    SELECT
        SR.Style_CD,
        SR.Color_CD,
        SR.Size_CD,
        SR.REVISION_NO,
        ROW_NUMBER() OVER (
            PARTITION BY SR.Style_CD, SR.Color_CD, SR.Size_CD
            ORDER BY SR.REVISION_NO DESC
        ) AS RN
    FROM DA.SKU_REVISION SR
) lr
JOIN DA.MFG_PATH mp
  ON mp.Style_CD    = lr.Style_CD
 AND mp.Revision_No = lr.Revision_No
WHERE lr.RN = 1;



SELECT
    sr.Style_CD
FROM (
    SELECT
        Style_CD,
        MAX(Revision_No) AS Revision_No
    FROM DA.SKU_REVISION
    GROUP BY Style_CD
) sr
LEFT JOIN DA.MFG_PATH mp
  ON mp.Style_CD    = sr.Style_CD
 AND mp.Revision_No = sr.Revision_No
GROUP BY sr.Style_CD
HAVING
    COUNT(DISTINCT CASE WHEN mp.MFG_PATH_ID IN ('93','95') THEN mp.MFG_PATH_ID END) >= 1
AND COUNT(DISTINCT CASE WHEN mp.MFG_PATH_ID = '90' THEN mp.MFG_PATH_ID END) = 0;



--- TEST

SELECT
    lr.Style_CD
FROM (
    SELECT
        SR.Style_CD,
        SR.Color_CD,
        SR.Size_CD,
        SR.REVISION_NO,
        ROW_NUMBER() OVER (
            PARTITION BY SR.Style_CD, SR.Color_CD, SR.Size_CD
            ORDER BY SR.REVISION_NO DESC
        ) AS RN
    FROM DA.SKU_REVISION SR
    WHERE SR.Style_CD = 'GUOCH8'   -- 👈 scope here (best place)
) lr
LEFT JOIN DA.MFG_PATH mp
  ON mp.Style_CD    = lr.Style_CD
 AND mp.Revision_No = lr.Revision_No
WHERE lr.RN = 1
GROUP BY lr.Style_CD
HAVING
    -- must have 93 or 95
    COUNT(
        DISTINCT CASE
            WHEN mp.MFG_PATH_ID IN ('93','95')
            THEN mp.MFG_PATH_ID
        END
    ) >= 1
AND
    -- must NOT have 90
    COUNT(
        DISTINCT CASE
            WHEN mp.MFG_PATH_ID = '90'
            THEN mp.MFG_PATH_ID
        END
    ) = 0;








