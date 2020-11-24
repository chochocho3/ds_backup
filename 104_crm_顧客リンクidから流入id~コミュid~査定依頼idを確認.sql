/* 顧客リンクidから流入id~コミュid~査定依頼idを確認 */
select
customer_links.id as 顧客リンクid
,inflows.id as 流入id
,communications.id as コミュid
,assessment_offers.id as 査定依頼id
from customer_links
left join inflows on inflows.customer_link_id = customer_links.id
left join communications on communications.first_inflow_id = inflows.id
left join assessment_offers on assessment_offers.communication_id = communications.id
where inflows.customer_link_id in (1495874,1418453)
