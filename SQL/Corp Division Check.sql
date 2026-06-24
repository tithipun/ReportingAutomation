select distinct d.*,c.corp_business_unit from da.dpr_Cumulative_leadtime@p_prod1.world d
inner join da.style@p_prod1.world s
on d.style_Cd=s.style_cd
inner join da.corp_division@p_prod1.world c
on s.corp_division_cd=c.corp_division_cd
inner join da.hbi_sequenced_demand h
on h.style_code=d.style_cd and h.color_code=d.color_cd
where d.corp_businesS_unit<>c.corp_business_unit
order by d.style_cd