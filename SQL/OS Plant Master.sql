--- TKS

WITH VEN_NAME AS 
(
SELECT VDN.VendorID 
, VDN.FacilityName 
FROM OneSource.dbo.Facilities VDN
WHERE VDN.FacilityType = 'HQ' --AND VDN.StatusCD <> 'I'--and VDN.VendorID  Like '12247%'
)
, FAC_NAME AS 
(
SELECT FCN.FacilityID 
, FCN.FacilityName 
, FCN.VendorID 
FROM OneSource.dbo.Facilities FCN
WHERE FCN.FacilityType <> 'HQ' --and FCN.VendorID  Like '12247%'
)
, PLT_CODE AS 
(
SELECT PCD.FacilityID 
, PCD.PlantCD 
FROM OneSource.dbo.FacilitySourceXREF PCD
WHERE PCD.PlantCD  <> '' --AND PCD.VendorLocationCD NOT LIKE 'L00%'-- AND PCD.DivisionCD <> 'CHP'  
)
SELECT  DISTINCT RTRIM(LTRIM(PC.PlantCD)) AS PlantCD
, FN.FacilityID 
, FN.FacilityName 
, FN.VendorID 
, VN.FacilityName AS VendorName
FROM FAC_NAME FN 
LEFT JOIN VEN_NAME VN 
ON FN.VendorID = VN.VendorID 
LEFT JOIN PLT_CODE PC
ON FN.FacilityID = PC.FacilityID
WHERE PC.PlantCD Is Not Null AND (FN.FacilityID NOT IN ('11275106','10383101','11084101'))


--- Internal

WITH PLANT_NAME AS (

SELECT RTRIM(LTRIM(f1.PlantCD)) AS PlantCD

, RTRIM(LTRIM(IIF(f1.PlantCD = '90', 'Phu Bai'

, IIF(f1.PlantCD = '91', 'Hung Yen North'

, IIF(f1.PlantCD = '93', 'Surin'

, IIF(f1.PlantCD = '95', 'Hung Yen South - Bra'

, IIF(f1.PlantCD = '96', 'Hung Yen Wovens'

, f1.PlantDESC))))))) AS PlantDESC

FROM ApparelNETII.dbo.Facilities f1

UNION

SELECT 'UNKNOWN'

, 'UNKNOWN'

)

SELECT *

FROM PLANT_NAME PN
ORDER BY PN.PlantCD

SELECT *
FROM OneSource.dbo.FacilitySourceXREF PCD
where facilityID = '10361106' 


select *
from Orders o
where orderNumber = 'X314967'

select *
from OrderLineItems oli
where orderID = '315681'

select *
from dbo.TransportationActivities ta

select *
from dbo.Transportations t 
where t.FromLocation = 'HPH' and t.tolocation = 'J1'

select *
from dbo.TransportationEvents te 

select *
from dbo.TransportationLeadTimes tlt 
where tlt.TransportationID = '1514'

--- FaciltiyID, Name and Plant code Master

SELECT 
    fx.PlantCD,
    CAST(f.FacilityID AS VARCHAR(20)) AS FacilityID,
    LTRIM(RTRIM(f.FacilityName)) AS FacilityName
FROM OneSource.dbo.Facilities f
LEFT JOIN OneSource.dbo.FacilitySourceXREF fx
    ON f.FacilityID = fx.FacilityID
WHERE f.FacilityID = 10006106
ORDER BY 
    fx.PlantCD, f.FacilityName;
   
--- Buyers Code

select *
from dbo.Buyers b 

select *
from dbo.OrderLineItems oli 
where orderid = '318237'





