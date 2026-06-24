select * FROM
(select 'DPR',style,color,attribute_cd,size_cd,round(CURRENT_QTY/12,2),d.rule_number , 
priority_sequence, ''
from dpr_demand d
union all
select 'On Hand' cat,oprsql.db_widgit.parse(r.resource_name,1,'~') selling_style_cd , 
 oprsql.db_widgit.parse(r.resource_name,2,'~') selling_color_cd ,
oprsql.db_widgit.parse(r.resource_name,3,'~')  selling_attribute_cd , 
 oprsql.db_widgit.parse(r.resource_name,4,'~')  selling_size_cd,
round(r.quantity_start/12,2) qty, 0 rule_number,0 priority_sequence,''  
 from resource_profile r  where resource_version = 1 
 and r.resource_type = 'INVENTORY' and r.profile_type = 'IN' and oprsql.db_widgit.parse(r.resource_name,5,'~')  = '**'
union all 
 select  'INTRANSIT' cat,selling_style_cd , selling_color_cd ,  selling_attribute_cd , selling_size_cd,
round(sum(p.curr_order_qty)/12,2) qty, 0 rule_number,0 priority_sequence,'' 
 from iss_prod_order_detail p, iss_prod_order p1  
 where   p.super_order = p1.super_order 
 and p1.production_status <> 'P'  
 and decode(p1.order_source_cd ,'MITS','Y',decode(substr(p1.super_Order,1,2),'IN','Y','N')) = 'Y'
group by selling_style_cd , selling_color_cd ,  selling_attribute_cd , selling_size_cd
  union all 
  select  'WIP' || decode(p1.order_source_cd,'RWRK','-Rework','')cat,
  selling_style_cd , selling_color_cd ,  selling_attribute_cd , selling_size_cd,
  round(sum(p.curr_order_qty)/12,2) qty, 0 rule_number,0 priority_sequence ,'' 
  from iss_prod_order_detail p, iss_prod_order p1  
  where  p.super_order = p1.super_order and p1.production_status <> 'P'  
  and decode(p1.order_source_cd ,'MITS','Y',decode(substr(p1.super_Order,1,2),'IN','Y','N')) = 'N'  
  group by decode(p1.order_source_cd,'RWRK','-Rework','') ,selling_style_cd , selling_color_cd ,  selling_attribute_cd , selling_size_cd
  ) x
where x.style = 'STTBB3'
  order by 2,3,4,5,1, priority_sequence