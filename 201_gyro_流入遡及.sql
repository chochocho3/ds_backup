--遡及--
--01_流入店舗用（流入作成）
INSERT INTO inflows (customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at) VALUES
=" ("&D2&", '"&TEXT(C2,"yyyy-MM-dd")&"', 9, 981, true, current_timestamp at time zone 'Japan', current_timestamp at time zone 'Japan')," --excel用

--確認--
--01_流入店舗用（流入作成）
="select id, customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at from inflows where customer_link_id in ("&A14&");" --excel用
