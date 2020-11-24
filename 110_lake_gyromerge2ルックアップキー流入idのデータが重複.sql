/* MK分析用キューブ：分析軸[gyro_merge2]のルックアップキー(流入id)のデータが重複しています */
select
	a_ev.customer_link_id as 顧客リンクid
	,c_inf.id as 流入id
	--,c_co.id as co_id
	,c_ao.id as 査定依頼id
	,a_ev.id as 案件id
	,a_ev_type.name as 案件種別
	,a_ev.created_at as 案件作成日時
	,a_ev.updated_at as 案件更新日時
	,co_emp.last_name || co_emp.first_name as 案件作成者
	,cm_emp.last_name || cm_emp.first_name as 案件対応者
	,a_ev_status.name as 案件ステータス
	,a_ev.event_completed_time as 案件完了日時
from
	crm.inflows c_inf
	left join crm.communications c_co on c_co.first_inflow_id = c_inf.id
	left join crm.assessment_offers c_ao on c_ao.communication_id = c_co.id
	left join assessment.events a_ev on a_ev.assessment_offer_id = c_ao.id
	inner join assessment.master_event_types a_ev_type on a_ev_type.id = a_ev.master_event_type_id
	inner join assessment.master_event_statuses a_ev_status on a_ev_status.id = a_ev.master_event_status_id
	inner join common.employees cm_emp on cm_emp.employee_number = a_ev.corresponding_employee_number
	inner join common.employees co_emp on co_emp.employee_number = a_ev.supported_employee_number
	where c_inf.id = 951507
