/*
契約ベースで大量に同じ契約レコードが表示された時
■原因は契約と案件（、コミュ）のステータスズレにより、起こる：ダイレクトに表現すると、案件がキャンセルになっている為に起きる
1. 契約ベースに対し、案件対応完了かつ簡易査定以外をjoinしている -> 案件情報が落ちた(null)状態でASSレコードができる
2. 1のレコードに対し、査定依頼idをキーにCRMレコードと紐づけると、CRM側が査定依頼idがnullのものに全てASSレコードが生成され、大量の同一契約レコードが生成される
*/
select
sc.id as 売買契約id
,sc_status.name as 契約状況 --1未成約、2成約、3不成約
,ev.id as 案件id
,ev_status.name as 案件対応状況--2対応中、3キャンセル、5対応完了
,ev.event_completed_time as 案件完了日時
,ev_type.name as 案件種別 --1訪問、2持込、3宅配、4法人、5簡易、6店舗
,ev.lock_version as 案件排他バージョン
,ev.updated_at as 案件更新日時
,ev.assessment_offer_id as 査定依頼id
,co.id as コミュid
,co_hand_status.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
,co_apo_con_status.name as コミュアポ成立状況 --2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
,co.updated_at as コミュ更新日時
,ap.id as アポid
,ap_status.name as アポ状況 --2対応中、3対応完了、4キャンセル
,ap.assessment_start_time as 現地着日時
,ap.assessment_end_time as 現地発日時
,ap.updated_at as アポ更新日時
from assessment.sales_contracts sc
join assessment.master_contract_statuses sc_status on sc_status.id = sc.master_contract_status_id
join assessment.events ev on ev.id = sc.event_id
join assessment.master_event_statuses ev_status on ev_status.id = ev.master_event_status_id
join assessment.master_event_types ev_type on ev_type.id = ev.master_event_type_id
join crm.assessment_offers ao on ao.id = ev.assessment_offer_id
join crm.communications co on co.id = ao.communication_id
join crm.master_handling_statuses co_hand_status on co_hand_status.id = co.master_handling_status_id
join crm.master_appointment_conclusion_statuses co_apo_con_status on co_apo_con_status.id = co.master_appointment_conclusion_status_id
join reservation.appointments ap on ap.inquiry_assessment_id = ev.assessment_offer_id
join reservation.master_appointment_statuses ap_status on ap_status.id = ap.master_appointment_status_id
where sc.id = 'eef559c6-314e-47d8-b5eb-f4d95e543dfb'

/* 以下、遡及文 */
--update events set lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan', event_completed_time = '2020-09-20 12:28:01.121195' where id = 'cfa12303-fadf-4e71-9ff2-e7d47f320f74';
--update communications set updated_at = current_timestamp at time zone 'Japan', master_appointment_conclusion_status_id = 2 where id = 701117;

/* 以下、確認文
--案件
select
ev.id as 案件id
,ev.lock_version as 排他ver
,ev_status.name as 案件対応状況
,ev.event_completed_time as 案件対応完了日時
,ev.updated_at as 案件更新日時
from events ev
join master_event_statuses ev_status on ev_status.id = ev.master_event_status_id
where ev.id = 'cfa12303-fadf-4e71-9ff2-e7d47f320f74'

--コミュニケーション
select
co.id as コミュid
,ap_con_st.name as アポ成立状況
,co_hand_st.name as コミュ対応状況
,co.updated_at as コミュ更新日時
from communications co
join master_appointment_conclusion_statuses ap_con_st on ap_con_st.id = co.master_appointment_conclusion_status_id
join master_handling_statuses co_hand_st on co_hand_st.id = co.master_handling_status_id
where co.id = 701117
*/
