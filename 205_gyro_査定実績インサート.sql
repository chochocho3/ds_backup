--確認（抽出）
select
sc.event_id
,sc.id as sc_id
,sc.is_settlement_confirmed
,sc.contract_date
,sc_st.name
,sc_tp.name
--,pf.id as pf_id
--,pf.event_id
--,pf.sales_contract_id
--,pf.total_purchase_price
--,pf.total_expected_sale_price
--,pf.gross_profit
--,pf.employee_number
--,pf.organization_code
--,pf.contract_date
--,pf.created_at
--,pf.updated_at
from sales_contracts sc
left join assessment_performances pf on pf.sales_contract_id = sc.id
join master_contract_statuses sc_st on sc_st.id = sc.master_contract_status_id
join master_contract_types sc_tp on sc_tp.id = sc.master_contract_type_id
where master_contract_status_id = 2 --契約状況：成約
and is_settlement_confirmed = true --決済確認済：true
and pf.id is null --査定実績がないもの

--インサート文
insert into assessment_performances values
="('"&A2&"', '"&B2&"', '"&C2&"', 0, 0, 0, 9999990, 20600000, '"&TEXT(E2,"yyyy-MM-dd")&"', current_timestamp at time zone 'Japan', current_timestamp at time zone 'Japan'),"

--update
--total_purchase_price, contract_date
update assessment_performances set
total_purchase_price = COALESCE(sc.transfer_amount, 0) + COALESCE(sc.cash_payment_amount, 0) ,contract_date = sc.contract_date ,updated_at = CURRENT_TIMESTAMP AT TIME ZONE 'Japan' 
="from sales_contracts sc where sales_contract_id = sc.id and sales_contract_id in ('"&C1&"');"

--total_expected_sale_price
--販売予想額取得
select
sc.id as sc_id
,sum(ai.expected_sale_price) as ai_expected_sale_price
,pf.id as pf_id
,sum(pf.total_expected_sale_price) as pf_expected_sale_price
from sales_contracts sc
inner join sales_contract_detail_lines scd on scd.sales_contract_id = sc.id
    and sc.master_contract_status_id = 2 --契約ステータス成約
    and sc.is_settlement_confirmed = true --決裁確認済み
    and scd.is_deleted = false 
inner join sales_contract_detail_line_groups scdg on scdg.sales_contract_detail_line_id = scd.id
    and scdg.is_deleted = false
inner join assessment_items ai on ai.id = scdg.assessment_item_id
inner join assessment_performances pf on pf.sales_contract_id = sc.id
="  and pf.sales_contract_id in ('"&C1&"')"
group by sc.id, pf.id

--販売予想額アップデート（K列に上で取得した販売予想額を入力してから）
="update assessment_performances set total_expected_sale_price = "&K2&", updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';"

--粗利アップデート
update assessment_performances
set gross_profit = total_expected_sale_price - total_purchase_price
="where id in ('"&A1&"');"

--案件対応者番号、組織コードアップデート
update assessment_performances set
employee_number = ev.corresponding_employee_number
,organization_code = ev.organization_code
,updated_at = CURRENT_TIMESTAMP AT TIME ZONE 'Japan'
from events ev
="and event_id in ('"&B1&"');"
where event_id = ev.id
