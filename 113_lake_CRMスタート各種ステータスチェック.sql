/* 各種ステータス齟齬確認 */
--アポを単一にする
with
ap_data as (
	select
	    ap.id
	    ,ap_tp.name as tp_name
	    ,ap_st.name as st_name
	    ,ap.updated_at
	    ,ap.event_id
	    ,ap.inquiry_assessment_id
	from (
		select
		distinct ap.inquiry_assessment_id
		,first_value(ap.id)
		over (
			partition by ap.inquiry_assessment_id
			order by ap.created_at desc
			range between unbounded preceding and unbounded following
		) as ap_id
		from reservation.appointments ap
	) as t1
	join reservation.appointments ap on ap.id = t1.ap_id
	join reservation.master_appointment_types ap_tp on ap_tp.id = ap.master_appointment_type_id
	join reservation.master_appointment_statuses ap_st on ap_st.id = ap.master_appointment_status_id
)
select
    cm.id as コミュid
    ,cm_st.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
    ,cm.updated_at as コミュ更新日時
    ,ao.id as 査定依頼id
    ,ass_tp.name as 査定種別 --1訪問査定、2持込査定、3宅配査定、4簡易査定、5査定依頼なし、6店舗査定、7CASH査定
    ,ao.updated_at as 査定依頼更新日時
    ,ap_con_st.name as アポ成立ステータス --1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
    ,ap.id as アポid
    ,tp_name as アポ種別 --1訪問査定、2持ち込み査定
    ,st_name as アポ状況 --1未対応、2対応中、3対応完了、4キャンセル
    ,ap.updated_at as アポ更新日時
    ,ev.id as 案件id
    ,ev_tp.name as 案件種別 --0未定義、1訪問査定案件、2持ち込み査定案件、3宅配査定案件、4法人査定案件、5簡易査定案件、6店舗査定案件
    ,ev_st.name as 案件対応状況 --0未定義、1一時保存、2対応中、3キャンセル、4削除、5対応完了、6未対応
    ,ev.updated_at as 案件更新日時
    --,sc.id as 売買契約id
    --,sc_st.name as 契約状況 --0未定義、1未成約、2成約、3不成約
    --,sc.is_settlement_confirmed as 決済確認
from
	crm.communications cm
    join crm.master_handling_statuses cm_st on cm_st.id = cm.master_handling_status_id
    join crm.master_appointment_conclusion_statuses ap_con_st on ap_con_st.id = cm.master_appointment_conclusion_status_id
    join crm.assessment_offers ao on ao.communication_id = cm.id
    join crm.master_assessment_types ass_tp on ass_tp.id = ao.master_assessment_type_id
    join ap_data ap on ap.inquiry_assessment_id = ao.id
    join assessment.events ev on ev.id = ap.event_id
    join assessment.master_event_types ev_tp on ev_tp.id = ev.master_event_type_id
    join assessment.master_event_statuses ev_st on ev_st.id = ev.master_event_status_id
    left join assessment.sales_contracts sc on sc.event_id = ev.id
    left join assessment.master_contract_statuses sc_st on sc_st.id = sc.master_contract_status_id
where
	--(ev_tp.id <> 5 and ev_st.id = 5 and cm_st.id <> 2) --簡易査定以外、案件対応完了、コミュ対応完了以外
	--or
	(ev_tp.id <> 5 and ev_st.id = 3 and cm_st.id = 2) --簡易査定以外、案件キャンセル、コミュ対応完了
