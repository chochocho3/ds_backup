begin;
--遡及--
--01_コミュ対応状況：1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
update communications set master_handling_status_id = , optimistic_lock_version = optimistic_lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = ;
--02_アポ成立ステータス：1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
update communications set master_appointment_conclusion_status_id = 2, optimistic_lock_version = optimistic_lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = 457283;

--確認--
--01,02_コミュ対応状況、コミュアポ成立ステータス確認
select
cm.id as コミュid
,master_handling_status_id as コミュ対応状況id
,hand_st.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
,cm.master_appointment_conclusion_status_id as アポ成立ステータスid
,ap_con_st.name as アポ成立ステータス --1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
,optimistic_lock_version as コミュ排他
,cm.updated_at as 更新日時
,current_timestamp at time zone 'Japan'
from communications cm
join master_handling_statuses hand_st on hand_st.id = cm.master_handling_status_id
join master_appointment_conclusion_statuses ap_con_st on ap_con_st.id = cm.master_appointment_conclusion_status_id
where cm.id in (533324);
