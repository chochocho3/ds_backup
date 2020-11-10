select 
	customer_link_id[1] as 顧客リンクid
	,array_length(customer_link_id, 1) as 成約回数
	,completed_date[1] as 第1成約日
	,completed_date[2] as 第2成約日
	,completed_date[3] as 第3成約日
	,completed_date[4] as 第4成約日
	,completed_date[5] as 第5成約日
	,completed_date[6] as 第6成約日
	,completed_date[7] as 第7成約日
	,completed_date[8] as 第8成約日
	,event_type[1] as 第1案件種別
	,event_type[2] as 第2案件種別
	,event_type[3] as 第3案件種別
	,event_type[4] as 第4案件種別
	,event_type[5] as 第5案件種別
	,event_type[6] as 第6案件種別
	,event_type[7] as 第7案件種別
	,event_type[8] as 第8案件種別
from (
	select
	array_agg(customer_link_id) as customer_link_id
	,array_agg(completed_date) as completed_date
	,array_agg(name) as event_type
	from (
		select
		customer_link_id
		,cast(event_completed_time as date) as completed_date
		,master_event_types.name
		from events
		inner join master_event_types on master_event_types.id = events.master_event_type_id
		--where customer_link_id in (1420906, 1419659, 1418782) --検証用抽出
		where (customer_link_id is not null and customer_link_id not in (969302, 1420906)) --渡邉 美由紀様（24回）、バンク社（15回）※カラムが多くなりすぎるので、カット
		and is_signed = true
		order by customer_link_id asc, event_completed_time asc
	) as t1
	group by customer_link_id
) as x
order by 成約回数 desc
