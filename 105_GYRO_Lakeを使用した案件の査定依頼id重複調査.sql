/* 案件の中で同じ査定依頼を持っている際の調査 */
select
assessment.events.id
,assessment.events.assessment_offer_id
,assessment.master_event_types.name
,assessment.master_event_statuses.name
,assessment.events.created_at
from assessment.events
left join crm.assessment_offers on crm.assessment_offers.id = assessment.events.assessment_offer_id
left join crm.communications on crm.communications.id = crm.assessment_offers.communication_id
inner join assessment.master_event_types on assessment.master_event_types.id = assessment.events.master_event_type_id
inner join assessment.master_event_statuses on assessment.master_event_statuses.id = assessment.events.master_event_status_id
where crm.communications.first_inflow_id = 837384
