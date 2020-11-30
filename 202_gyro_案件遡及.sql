begin;
--遡及--
--01_案件対応状況：1一時保存、2対応中、3キャンセル、4削除、5対応完了
update events set master_event_status_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
--02_案件完了日時
update events set event_completed_time = '', lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
="update events set event_completed_time = '"&TEXT(B2,"yyyy-MM-dd")&" 19:00:00', lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';" --excel用
--03_案件顧客リンクid
update events set customer_link_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';

--10_流入店舗用
INSERT INTO inflows (customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at) VALUES
=" ("&D2&", '"&TEXT(C2,"yyyy-MM-dd")&"', 9, 981, true, current_timestamp at time zone 'Japan', current_timestamp at time zone 'Japan'),"

--確認--
--01_案件対応状況
select id, master_event_status_id, lock_version, updated_at from events where id = '';
--02_案件完了日時
select id, event_completed_time, lock_version, updated_at from events where id = '';
="select id, event_completed_time, lock_version, updated_at from events where id in ('"&A10&"');" --excel用
--03_案件顧客リンクid
select id, customer_link_id, lock_version, updated_at from events where id = '';

--10_流入店舗用
="select id, customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at from inflows where customer_link_id in ("&A14&");" --excel用
