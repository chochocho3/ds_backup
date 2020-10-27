/* 査定依頼idが重複している案件情報 */
select
events.id
,events.assessment_offer_id
,master_event_statuses.name
,master_event_types.name
,events.customer_link_id
from events
inner join master_event_types on master_event_types.id = events.master_event_type_id
inner join master_event_statuses on master_event_statuses.id = events.master_event_status_id
where events.assessment_offer_id in (xxx)
order by events.assessment_offer_id
