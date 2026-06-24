FROM ((OPLIB.OPP070 A  
    LEFTEa OPLIB.OPP770 B 
        ON CASE 
            WHEN A.C1ASNB = 0 THEN A.C1CUTO 
            ELSE A.C1ASNB 
           END = B.C2CUTO) 
JOIN OPLIB.OPP070 C 
    ON CASE 
        WHEN A.C1ASNB = 0 THEN A.C1CUTO 
        ELSE A.C1ASNB 
       END = C.C1CUTO)
WHERE A.C1MUTP = '' 
  AND ((A.C1CDTC * 1000000) + A.C1CDTE) BETWEEN 20250501 AND 20250502 
  AND A.C1SPLT IN ('90','91','93')

  SELECT *
  FROM OPLIB.OPP070 A
  
  
  --- Vendor Acknowledge
  
  SELECT
    -- Plant & PO Info
    T1.LMPLNT                               AS PLANT,
    T1.LMPONO                               AS PO_NUMBER,
    T1.LMPOLN                               AS PO_LINE,
    TRIM(T1.LMPONO) ||'_'|| TRIM(T1.LMPOLN) AS PO_POLINE,

    -- Vendor Info
    T1.LMVEND                               AS VENDOR_NUMBER,
    T4.K0SDSC                               AS VENDOR_DESCRIPTION,

    -- Item Info
    T1.LMLAWI                               AS LAWSON_ITEM,
    LEFT(T1.LMLAWI, 6)                      AS STYLE,

    -- Shipment Info
    T2.LSREF#                               AS SHIPMENT_NUM,
    T3.LSVNLT                               AS VENDOR_LOT,
    T1.LMSTAT                               AS SHIPMENT_STATUS,

    -- Quantities
    T1.LMORQT                               AS ORDER_QUANTITY,
    T2.LSSHQT                               AS ACK_QUANTITY,
    T2.LSREQT                               AS RECD_QUANTITY,
    T1.LMUOM                                AS UOM,
    T1.LMCONV                               AS UOM_CONVERSION_FACTOR,

    -- Dates
    T1.LMCRDT                               AS ORDER_DATE,
    T1.LMEDVD                               AS DELIVERY_DATE,
    T2.LSSHDT                               AS ACK_DATE,
    T2.LSREDT                               AS RECD_DATE

FROM HQ400B.ICLIB.ICPLMST T1

    LEFT JOIN HQ400B.ICLIB.ICPLSHP T2
        ON  T1.LMPLNT = T2.LSPLNT
        AND T1.LMPONO = T2.LSPONO
        AND T1.LMPOLN = T2.LSPOLN

    LEFT JOIN HQ400B.ICLIB.ICPLSHPEX T3
        ON  T2.LSPLNT = T3.LSPLNT
        AND T2.LSPONO = T3.LSPONO
        AND T2.LSREF# = T3.LSREF#

    LEFT JOIN PDLIB.PTP001 T4
        ON  T1.LMVEND = T4.K0TCOD

WHERE
    T1.LMPLNT IN ('90','91','92','93','94','95','96','98')
    AND T1.LMEDVD >= ?
    AND T1.LMEDVD <= ?
    AND T1.LMVEND LIKE ?
    AND T4.K0TCAT  = 'FV'

ORDER BY
    T1.LMPLNT,
    T1.LMVEND,
    T1.LMPONO,
    T1.LMPOLN,
    T2.LSREF#
  
  --- Vendor Name
  
SELECT DISTINCT  T4.K0SDSC AS VENDOR_DESCRIPTION, T1.LMVEND AS VENDOR_NUMBER
FROM HQ400B.ICLIB.ICPLMST T1 JOIN PDLIB.PTP001 T4 ON T1.LMVEND = T4.K0TCOD
WHERE T1.LMPLNT IN ('90','91','92','93','94','95','96','98')
ORDER BY  T1.LMVEND