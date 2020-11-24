/*
select
assessment_items.id as 査定商材ID
,assessment_items.created_at as 査定商材登録日
--,assessment_items.master_assessment_item_type_id
,master_assessment_item_types.name as 査定商材種別
--,master_assessment_item_element_selections.name as ブランド名
,assessment_items.registered_employee_name as 登録従業員
,assessment_items.primary_appraiser_employee_name as 一次査定者
,assessment_items.in_progress_appraiser_employee_name as 修正指示者
,assessment_items.memo_for_appraiser as 商材登録者への連絡事項
,assessment_items.memo_for_expert_appraiser as 販促への連絡事項
,assessment_items.updated_at as 修正指示日
--,assessment_items.master_assessment_status_id
,master_assessment_statuses.name as ステータス
from assessment_items
inner join master_assessment_item_types on master_assessment_item_types.id = assessment_items.master_assessment_item_type_id and assessment_items.master_assessment_item_type_id in (18,19,20) --ブランド品
inner join master_assessment_statuses on master_assessment_statuses.id = assessment_items.master_assessment_status_id and assessment_items.master_assessment_status_id = 2 --査定情報不足
inner join master_assessment_item_elements on master_assessment_item_elements.master_assessment_item_type_id = master_assessment_item_types.id
inner join master_assessment_item_element_selection_relations on master_assessment_item_element_selection_relations.master_assessment_item_element_id = master_assessment_item_elements.id
inner join master_assessment_item_element_selections on master_assessment_item_element_selections.id = master_assessment_item_element_selection_relations.master_assessment_item_element_selection_id
where assessment_items.created_at >= '2020-10-01' and assessment_items.created_at < '2020-11-01'
*/

--/*
select
assessment_items.id as 査定商材ID
,assessment_items.created_at as 査定商材登録日
--,assessment_items.master_assessment_item_type_id
--,master_assessment_item_types.name as 査定商材種別
,master_assessment_item_element_selections.name as ブランド名
,assessment_items.registered_employee_name as 登録従業員
,assessment_items.primary_appraiser_employee_name as 一次査定者
,assessment_items.in_progress_appraiser_employee_name as 修正指示者
,assessment_items.memo_for_appraiser as 商材登録者への連絡事項
,assessment_items.memo_for_expert_appraiser as 販促への連絡事項
,assessment_items.updated_at as 修正指示日
--,assessment_items.master_assessment_status_id
,master_assessment_statuses.name as ステータス
from master_assessment_item_element_selection_relations
inner join master_assessment_item_element_selections on master_assessment_item_element_selections.id = master_assessment_item_element_selection_relations.master_assessment_item_element_id
inner join master_assessment_item_elements on master_assessment_item_elements.id = master_assessment_item_element_selection_relations.master_assessment_item_element_selection_id
inner join master_assessment_item_types on master_assessment_item_types.id = master_assessment_item_elements.master_assessment_item_type_id
inner join assessment_items on assessment_items.master_assessment_item_type_id = master_assessment_item_types.id
--inner join assessment_items on assessment_items.master_assessment_item_type_id = master_assessment_item_elements.master_assessment_item_type_id
inner join master_assessment_statuses on master_assessment_statuses.id = assessment_items.master_assessment_status_id
where assessment_items.created_at >= '2020-07-01' and assessment_items.created_at < '2020-08-01'
and assessment_items.master_assessment_item_type_id in (18,19,20) --ブランド品
and assessment_items.master_assessment_status_id = 2 --査定情報不足
--*/
