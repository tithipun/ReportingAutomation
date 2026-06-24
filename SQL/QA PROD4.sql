SELECT *
FROM da.ISS_PROD_SUMMARY iss
WHERE STYLE_cd IN ('PPCNS6','AC1212','BXTNS0')

SELECT *
FROM da.ISS_PROD_SUMMARY iss
WHERE STYLE_cd IN ('PPCNS6','AC1212','BXTNS0')

SELECT *
FROM da.ISS_PROD_SUMMARY iss
WHERE STYLE_cd = 'BXTNS0'

SELECT *
FROM da.HBI_SEQUENCED_DEMAND hsd
WHERE STYLE_CODE IN ('GOGTH2','GPPMHP','GUPSYB')

SELECT *
FROM 
    Da.iss_prod_summary a
INNER JOIN 
    DA.HBI_SEQUENCED_DEMAND b
    ON a.priority = b.sequence_number
WHERE 
    a.SPILL_OVER_IND = 'Y'
    AND b.critical_ratio <= 3
    AND a.SELLING_STYLE_CD = b.style_code
    AND b.customer_ship_date < b.BENCH_MARK_DATE + 273


SELECT 
    c.capacity_group,
    c.capacity_alloc,
    c.plant,
    COUNT(*) AS record_count,
    SUM(c.total_capacity) AS total_capacity_sum,
    MIN(c.week_end_date) AS earliest_week,
    MAX(c.week_end_date) AS latest_week
FROM da.socks_sit_skus a
JOIN iss_cap_alloc_xref_plan b 
    ON a.style_cd = b.style_cd
JOIN avyx_capacity c 
    ON (
           (b.sew_alloc = c.capacity_alloc AND c.capacity_group = 'SEW')
        OR (b.cut_alloc = c.capacity_alloc AND c.capacity_group = 'CUT')
        OR (b.src_alloc = c.capacity_alloc AND c.capacity_group = 'SRC')
       )
GROUP BY 
    c.capacity_group,
    c.capacity_alloc,
    c.plant
ORDER BY  
    c.capacity_group,
    c.ca

'Check Sew Allocation'

SELECT *
FROM da.AVYX_CAPACITY_SOCKS acs
    
SELECT *
FROM da.ISS_CAP_ALLOC_XREF icax
WHERE icax.style_cd in ('HBA0N6','HBPX99')

SELECT *
FROM da.ISS_CAP_ALLOC_XREF icax
WHERE icax.SEW_ALLOC = '120NOT_SC'

SELECT *
FROM da.ISS_PROD_SUMMARY ips 
WHERE style_cd in ('PPCNS6','BXTNS0')


SELECT *
FROM da.ISS_PROD_ORDER_DETAIL ipod


SELECT DISTINCT 
    STYLE_CODE, 
    COLOR_CODE, 
    CUMULATIVE_LEADTIME
FROM da.HBI_SEQUENCED_DEMAND hsd
WHERE (STYLE_CODE, COLOR_CODE) IN (
    ('GOGTH2', 'ASF'),
    ('GPPMHP', 'ASF'),
    ('GUPSYB', 'ASF'),
    ('TGPTB6', 'ASF'),
    ('GUOCB8', 'N31'),
    ('GCPHP4', 'ASF'),
    ('GCEMW5', '00F'),
    ('GUOCH8', 'N31'),
    ('GOSSBK', 'ASF'),
    ('GOSSHP', 'ASF')
)

SELECT
    STYLE_CODE,
    COLOR_CODE,
    CUMULATIVE_LEADTIME,
    CREATE_DATE
FROM (
    SELECT
        STYLE_CODE,
        COLOR_CODE,
        CUMULATIVE_LEADTIME,
        CREATE_DATE,
        ROW_NUMBER() OVER (
            PARTITION BY STYLE_CODE, COLOR_CODE 
            ORDER BY CREATE_DATE DESC
        ) AS rn
    FROM da.HBI_SEQUENCED_DEMAND
    WHERE (STYLE_CODE, COLOR_CODE) IN (
        ('GOGTH2', 'ASF'),
        ('GPPMHP', 'ASF'),
        ('GUPSYB', 'ASF'),
        ('TGPTB6', 'ASF'),
        ('GUOCB8', 'N31'),
        ('GCPHP4', 'ASF'),
        ('GCEMW5', '00F'),
        ('GUOCH8', 'N31'),
        ('GOSSBK', 'ASF'),
        ('GOSSHP', 'ASF')
    )
) ranked
WHERE rn = 1

