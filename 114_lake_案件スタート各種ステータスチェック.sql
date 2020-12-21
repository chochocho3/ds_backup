/* 各種ステータス齟齬確認 */
select
    ev.id as 案件id
    ,ev_tp.name as 案件種別 --0未定義、1訪問査定案件、2持ち込み査定案件、3宅配査定案件、4法人査定案件、5簡易査定案件、6店舗査定案件
    ,ev_st.name as 案件対応状況 --0未定義、1一時保存、2対応中、3キャンセル、4削除、5対応完了、6未対応
    ,sc.id as 売買契約id
    ,sc_st.name as 契約状況 --0未定義、1未成約、2成約、3不成約
    ,sc.is_settlement_confirmed as 決済確認
    ,ao.id as 査定依頼id
    ,ass_tp.name as 査定種別 --1訪問査定、2持込査定、3宅配査定、4簡易査定、5査定依頼なし、6店舗査定、7CASH査定
    ,cm.id as コミュid
    ,hand_st.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
    ,ap_con_st.name as アポ成立ステータス --1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
    ,ap.id as アポid
    ,ap_tp.name as アポ種別 --1訪問査定、2持ち込み査定
    ,ap_st.name as アポ状況 --1未対応、2対応中、3対応完了、4キャンセル
from
    assessment.events ev
    inner join assessment.master_event_types ev_tp on ev_tp.id = ev.master_event_type_id
    inner join assessment.master_event_statuses ev_st on ev_st.id = ev.master_event_status_id
    left join assessment.sales_contracts sc on sc.event_id = ev.id
    inner join assessment.master_contract_statuses sc_st on sc_st.id = sc.master_contract_status_id
    left join crm.assessment_offers ao on ao.id = ev.assessment_offer_id
    inner join crm.master_assessment_types ass_tp on ass_tp.id = ao.master_assessment_type_id
    left join crm.communications cm on cm.id = ao.communication_id
    inner join crm.master_handling_statuses hand_st on hand_st.id = cm.master_handling_status_id
    inner join crm.master_appointment_conclusion_statuses ap_con_st on ap_con_st.id = cm.master_appointment_conclusion_status_id
    left join reservation.appointments ap on ap.inquiry_assessment_id = ao.id
    inner join reservation.master_appointment_types ap_tp on ap_tp.id = ap.master_appointment_type_id
    inner join reservation.master_appointment_statuses ap_st on ap_st.id = ap.master_appointment_status_id 
where ev.id in ('')
