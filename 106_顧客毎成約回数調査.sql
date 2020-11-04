select
customer_links.customer_id as gyro_customer_id
,customer_links.id as gyro_customer_link_id
--,customer_remarks
,case when customer_remarks like '%SF移行顧客%' then substr(customer_remarks, strpos(customer_remarks, 'SF移行顧客') + 7, 15) else null end as salesforce_id
,case when customer_remarks like '%Asys移行顧客%' then substr(customer_remarks, strpos(customer_remarks, 'AsysNo') + 7, 6) else null end as asys_id
from customer_links
inner join customers on customers.id = customer_links.customer_id
--limit 10000

