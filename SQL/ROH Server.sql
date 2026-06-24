select * from ROH_planning.dbo.ibp_gross_demand where WEEK_DEMAND='202623' and SELLING_STYLE_CD = 'DA3036'

select * from ROH_planning.dbo.ibp_gross_demand_archive where WEEK_DEMAND='202610'

SELECT MIN(WEEK_DEMAND) AS oldest_week
FROM ROH_planning.dbo.ibp_gross_demand_archive;