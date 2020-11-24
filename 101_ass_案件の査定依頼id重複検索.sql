/* 案件の査定依頼id重複存在確認 */
select *
        from (
                select
                distinct events.assessment_offer_id as assessment_offer_id
                ,count(events.id) as count_event
                from events
                where events.master_event_type_id <> 5 --簡易査定
                and events.master_event_status_id <> 3 --キャンセル
                group by events.assessment_offer_id
        ) as t
where count_event > 1 
