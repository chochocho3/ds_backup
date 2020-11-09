/*
	select a[1] , a[2]
	from (
	select
	--distinct events.customer_link_id
	--array_agg(master_event_types.name)
	array_agg(cast(events.event_completed_time as date))
	from events
	inner join master_event_types on master_event_types.id = events.master_event_type_id
	where events.is_signed = true
	group by events.customer_link_id
	) as dt(a)
*/
--/*
	select
	events.customer_link_id
	--array_agg(master_event_types.name)
	,cast(events.event_completed_time as date)
	from events
	inner join master_event_types on master_event_types.id = events.master_event_type_id
	where events.is_signed = true
	order by events.event_completed_time asc
--*/

