--遡及--
--01_案件対応状況：1一時保存、2対応中、3キャンセル、4削除、5対応完了
update events set master_event_status_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';

--02_案件完了日時
update events set event_completed_time = '', lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
="update events set event_completed_time = '"&TEXT(B2,"yyyy-MM-dd")&" 19:00:00', lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';" --excel用

--03_案件顧客リンクid
update events set customer_link_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
="update events set customer_link_id = "&D2&", lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';" --excel用

--04_案件流入id
update events set inflow_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
="update events set inflow_id = "&E2&", lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';" --excel用

--10_案件店舗遡及：顧客リンクid(03), 流入id(04)
update events set customer_link_id = , inflow_id = , lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '';
="update events set customer_link_id = "&D2&", inflow_id = "&E2&", lock_version = lock_version + 1, updated_at = current_timestamp at time zone 'Japan' where id = '"&A2&"';" --excel用



--確認--
--01_案件対応状況
select id, master_event_status_id, lock_version, updated_at from events where id = '';

--02_案件完了日時
select id, event_completed_time, lock_version, updated_at from events where id = '';
="select ev.id, ev_st.name, event_completed_time, lock_version, ev.updated_at from events ev join master_event_statuses ev_st on ev_st.id = ev.master_event_status_id where ev.id in ('"&A1&"');" --excel用

--03_案件顧客リンクid
select id, customer_link_id, lock_version, updated_at from events where id = '';

--04_案件流入id
select id, inflow_id = , lock_version, updated_at from events where id = '';

--10_案件店舗遡及：顧客リンクid(03), 流入id(04)
select id, customer_link_id, inflow_id, lock_version, updated_at from events where id in ('');
="select id, customer_link_id, inflow_id, lock_version, updated_at from events where id in ('"&A1&"');" --excel用
