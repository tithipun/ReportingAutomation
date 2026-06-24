select *
From dbo.Buyers b

select *
From onesource.dbo.OrderLineItems oli 
where orderID in ('320928','320910')

select *
From onesource.dbo.OrderLineItems oli 
where orderID = '316611'

Select *
FROM OneSource.dbo.POManifestHistory
where OrderID = '316611'

Select *
FROM OneSource.dbo.POManifestHistory
where OrderID in ('320928','320910')

select *
from onesource.dbo.TransportationLeadTimes tlt 
where facilityID = '11189137' and ArrivalPortCD = 'LAX'

select *
from onesource.dbo.Facilities f
where VendorID = '11189'

select *
from onesource.dbo.Activities a 

--- Title Transfer

SELECT 
    mc.Manifest, 
    f.FacilityName, 
    m.StatusIND, 
    m.StatusDate, 
    o.DivisionCD, 
    o.OrderNumber, 
    olir.LineItemID, 
    olir.StyleCd, 
    olir.ColorCD, 
    olir.SizeCD, 
    olir.AttributeCD, 
    SUM(c.Quantity)                 AS [Sum of Quantity]

FROM OneSource.dbo.Containers               c
    INNER JOIN OneSource.dbo.ManifestContainers         mc      ON  mc.ContainerID      = c.ContainerID
    INNER JOIN OneSource.dbo.Manifests                  m       ON  m.Manifest          = mc.Manifest
                                                                AND m.FacilityID        = c.FacilityID
    INNER JOIN OneSource.dbo.Facilities                 f       ON  f.FacilityID        = c.FacilityID
    INNER JOIN OneSource.dbo.OrderLineItemContainers    olic    ON  olic.ContainerID    = c.ContainerID
    INNER JOIN OneSource.dbo.OrderLineItemReleases      olir    ON  olir.LineItemID     = olic.LineItemID
                                                                AND olir.OrderID        = olic.OrderID
                                                                AND olir.FacilityID     = c.FacilityID
    INNER JOIN OneSource.dbo.OrderLineItems             oli     ON  oli.LineItemID      = olic.LineItemID
                                                                AND oli.OrderID         = olic.OrderID
                                                                AND oli.FacilityID      = c.FacilityID
    INNER JOIN OneSource.dbo.Orders                     o       ON  o.OrderID           = olic.OrderID

WHERE 
    m.StatusIND = 'P'                                               -- all P on any date
    OR CAST(m.StatusDate AS DATE) = CAST(GETDATE() AS DATE)        -- all statuses today

GROUP BY 
    mc.Manifest, 
    f.FacilityName, 
    m.StatusIND, 
    m.StatusDate, 
    o.DivisionCD, 
    o.OrderNumber, 
    olir.LineItemID, 
    olir.StyleCd, 
    olir.ColorCD, 
    olir.SizeCD, 
    olir.AttributeCD

ORDER BY 
    mc.Manifest

    
---- TITLE TEST    

SELECT 
    mc.Manifest, 
    f.FacilityName, 
    m.StatusIND, 
    m.StatusDate, 
    o.DivisionCD, 
    o.OrderNumber, 
    olir.LineItemID, 
    olir.StyleCd, 
    olir.ColorCD, 
    olir.SizeCD, 
    olir.AttributeCD, 
    SUM(c.Quantity)                 AS [Sum of Quantity]

FROM OneSource.dbo.Containers               c
    INNER JOIN OneSource.dbo.ManifestContainers         mc      ON  mc.ContainerID      = c.ContainerID
    INNER JOIN OneSource.dbo.Manifests                  m       ON  m.Manifest          = mc.Manifest
                                                                AND m.FacilityID        = c.FacilityID
    INNER JOIN OneSource.dbo.Facilities                 f       ON  f.FacilityID        = c.FacilityID
    INNER JOIN OneSource.dbo.OrderLineItemContainers    olic    ON  olic.ContainerID    = c.ContainerID
    INNER JOIN OneSource.dbo.OrderLineItemReleases      olir    ON  olir.LineItemID     = olic.LineItemID
                                                                AND olir.OrderID        = olic.OrderID
                                                                AND olir.FacilityID     = c.FacilityID
    INNER JOIN OneSource.dbo.OrderLineItems             oli     ON  oli.LineItemID      = olic.LineItemID
                                                                AND oli.OrderID         = olic.OrderID
                                                                AND oli.FacilityID      = c.FacilityID
    INNER JOIN OneSource.dbo.Orders                     o       ON  o.OrderID           = olic.OrderID

WHERE 
    m.StatusDate >= '2026-01-01'
    AND m.StatusDate < '2027-01-01'

GROUP BY 
    mc.Manifest, 
    f.FacilityName, 
    m.StatusIND, 
    m.StatusDate, 
    o.DivisionCD, 
    o.OrderNumber, 
    olir.LineItemID, 
    olir.StyleCd, 
    olir.ColorCD, 
    olir.SizeCD, 
    olir.AttributeCD

ORDER BY 
    mc.Manifest


    