/* 法人以外で査定依頼が紐づいていない案件 */
select
events.id
,events.assessment_offer_id
,master_event_statuses.name
,master_event_types.name
from events
inner join master_event_types on master_event_types.id = events.master_event_type_id
inner join master_event_statuses on master_event_statuses.id = events.master_event_status_id
where events.assessment_offer_id = 0 --査定依頼idなし
and events.master_event_type_id <> 4 --法人案件
and events.master_event_status_id <> 3 --キャンセル以外
order by events.assessment_offer_id
