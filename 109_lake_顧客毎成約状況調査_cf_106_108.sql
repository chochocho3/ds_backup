with
/* CRM側（配列の要素が全て同じだと仮定し、1番目の要素を抜き出し） */
crm_data as (
	select
		gyro_customer_id[1]
		,salesforce_id[1]
		,asys_id[1]
	from (
	/* Salesforce_idかAsys_idが含まれているレコードのみで顧客リンクidでグループ化 */
		select
			array_agg(t3.gyro_customer_id) as gyro_customer_id
			,array_length(array_agg(t3.gyro_customer_id), 1) 
			,array_agg(t3.salesforce_id) as salesforce_id
			,array_agg(t3.asys_id) as asys_id
		from (
		/* 顧客備考よりsf_idとasys_idを抽出 */
			select
				crm.customer_links.customer_id as gyro_customer_id
				--,crm.customer_links.id as gyro_customer_link_id
				,case when crm.customers.customer_remarks like '%SF移行顧客%' then substr(crm.customers.customer_remarks, strpos(crm.customers.customer_remarks, 'SF移行顧客') + 7, 15) else null end as salesforce_id
				,case when crm.customers.customer_remarks like '%Asys移行顧客%' then substr(crm.customers.customer_remarks, strpos(crm.customers.customer_remarks, 'AsysNo') + 7, 6) else null end as asys_id
			from crm.customer_links
			inner join crm.customers on crm.customers.id = crm.customer_links.customer_id
			where crm.customers.id not in (712156) --無言非通知
		) as t3
		where salesforce_id is not null and asys_id is not null
		group by gyro_customer_id
	) as t4
)
/* ASS側（顧客id毎成約情報） */
,ass_data as (
	select
		customer_id[1] as 顧客id
		,array_length(customer_id, 1) as 成約回数
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
		array_agg(t1.customer_id) as customer_id
		,array_agg(t1.completed_date) as completed_date
		,array_agg(t1.name) as event_type
		from (
			select
			crm.customer_links.customer_id
			,cast(event_completed_time as date) as completed_date
			,master_event_types.name
			from assessment.events
			inner join assessment.master_event_types on assessment.master_event_types.id = assessment.events.master_event_type_id
			inner join crm.customer_links on crm.customer_links.id = assessment.events.customer_link_id
			--where customer_link_id in (1420906, 1419659, 1418782) --検証用抽出
			where (assessment.events.customer_link_id is not null and assessment.events.customer_link_id not in (969302, 1420906)) --渡邉 美由紀様（24回）、バンク社（15回）※カラムが多くなりすぎるので、カット
			and assessment.events.is_signed = true
			order by crm.customer_links.customer_id asc, assessment.events.event_completed_time asc
		) as t1
		group by t1.customer_id
	) as x
	order by 成約回数 desc
)
select *
from ass_data
left join crm_data on crm_data.gyro_customer_id = ass_data.顧客id
