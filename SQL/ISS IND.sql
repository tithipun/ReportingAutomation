SELECT 
    SKU.STYLE_CD, 
    SKU.COLOR_CD, 
    SKU.ATTRIBUTE_CD, 
    SKU.SIZE_CD, 
    SKU.ISS_IND, 
    SKU.PRIMARY_DC_REVISION_NO
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
  
SELECT SKU.STYLE_CD, SKU.COLOR_CD, SKU.ATTRIBUTE_CD, SKU.SIZE_CD, SKU.ISS_IND, SKU.PRIMARY_DC_REVISION_NO
FROM DA.SKU SKU
WHERE SKU.style_cd in 'CFFMA3' AND 

SELECT SKU.STYLE_CD, SKU.COLOR_CD, SKU.ATTRIBUTE_CD, SKU.SIZE_CD, SKU.ISS_IND
FROM DA.SKU SKU
Where SKU.STYLE_CD in ('CFFMA3','CFFMF3')
ORDER BY SKU.STYLE_CD, SKU.COLOR_CD, SKU.SIZE_CD

SELECT *
FROM da.sku