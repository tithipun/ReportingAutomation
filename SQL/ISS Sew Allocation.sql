
'Check Sew Allocation'

SELECT *
FROM da.ISS_CAP_ALLOC_XREF icax
WHERE icax.style_cd in ('XTMGP3','STTBA3')

SELECT *
FROM da.ISS_CAP_ALLOC_XREF icax
WHERE icax.SEW_ALLOC = 'P_MPPSCM_B'

SELECT *
FROM da.ISS_PROD_SUMMARY ips 
WHERE style_cd = '4F31'

SELECT *
FROM da.ISS_CAP_ALLOC_XREF icax
WHERE icax.style_cd in ('PPCNS6','BXTNS0')






