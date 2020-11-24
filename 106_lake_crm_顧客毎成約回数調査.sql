/* CRM側（配列の要素が全て同じだと仮定し、1番目の要素を抜き出し） */
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
