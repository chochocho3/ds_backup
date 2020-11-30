/* 各種ステータス齟齬確認 */
select
	co.id as コミュid
	,hand_st.name as コミュ対応状況 --1対応中、2対応完了、3スナッチ、4要折り返し、5放棄呼、6即切電
	,apo_con_st.name as アポ成立ステータス --1未依頼、2アポ成立、3アポ不成立、4追客見込み、5アポ保留、6アポ除外、7キャンセル
	,ao.id as 査定依頼id
	--,apo_st.name as アポ状況 --1未対応、2対応中、3対応完了、4キャンセル
	--,ev.id
from
	crm.communications co
	join crm.master_handling_statuses hand_st on hand_st.id = co.master_handling_status_id
	join crm.master_appointment_conclusion_statuses apo_con_st on apo_con_st.id = co.master_appointment_conclusion_status_id
	left join crm.assessment_offers ao on ao.communication_id = co.id
	left join reservation.appointments ap on ap.inquiry_assessment_id = ao.id
	--join reservation.master_appointment_statuses apo_st on apo_st.id = ap.master_appointment_status_id
	--join assessment.events ev on ev.assessment_offer_id = ao.id
where co.id in (457283, 459183)
