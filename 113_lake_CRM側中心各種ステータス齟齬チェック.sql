/* 各種ステータス齟齬確認 */
select
    cm.id as コミュid
    ,hand_st.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
    ,ap_con_st.name as アポ成立ステータス --1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
    ,ao.id as 査定依頼id
    ,ap.id as アポid
    ,ap_st.name as アポ状況 --1未対応、2対応中、3対応完了、4キャンセル
    ,ev.id as 案件id
    ,ev_st.name as 案件対応状況 --0未定義、1一時保存、2対応中、3キャンセル、4削除、5対応完了
from
    crm.communications cm
    join crm.master_handling_statuses hand_st on hand_st.id = cm.master_handling_status_id
    join crm.master_appointment_conclusion_statuses ap_con_st on ap_con_st.id = cm.master_appointment_conclusion_status_id
    left join crm.assessment_offers ao on ao.communication_id = cm.id
    left join reservation.appointments ap on ap.inquiry_assessment_id = ao.id
    left join reservation.master_appointment_statuses ap_st on ap_st.id = ap.master_appointment_status_id
    left join assessment.events ev on ev.assessment_offer_id = ao.id
    left join assessment.master_event_statuses ev_st on ev_st.id = ev.master_event_status_id
where cm.id in (533324)
