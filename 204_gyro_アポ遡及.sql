--遡及
update appointments set assessment_end_time = '2020-11-12 19:00:00', master_appointment_status_id = 3, updated_at = current_timestamp at time zone 'Japan' where id = 149126;

--確認
select
ap.id as アポid
,ap.inquiry_assessment_id as 査定依頼id
,ap.assessment_end_time as 現地発日時
,master_appointment_statuses.name as アポイントステータス --1未対応、2対応中、3対応完了、4キャンセル
,master_appointment_types.name as アポイントメント種類 --1訪問査定、2持ち込み査定
,ap.updated_at as 更新日時
from appointments ap
join master_appointment_statuses on master_appointment_statuses.id = ap.master_appointment_status_id
join master_appointment_types on master_appointment_types.id = ap.master_appointment_type_id
where ap.id in ()

