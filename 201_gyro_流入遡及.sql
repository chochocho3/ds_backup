--遡及--
--01_流入店舗用（流入作成）
INSERT INTO inflows (customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at) VALUES
=" ("&D2&", '"&TEXT(C2,"yyyy-MM-dd")&"', 9, 1152, true, current_timestamp at time zone 'Japan', current_timestamp at time zone 'Japan')," --excel用
--02_流入cid（マーケ遡及）
update inflows set master_campaign_id = xx where id = xx;
="update inflows set master_campaign_id = "&B2&" where id = "&A2&";" --excel用
--03_流入sid（マーケ遡及）
update inflows set session_id = xx where id = xx;
="update inflows set session_id = '"&B2&"' where id = "&A2&";" --excel用
--04_流入流入種別（マーケ遡及）
update inflows set master_inflow_type_id = xx where id = xx;
="update inflows set master_inflow_type_id = '"&C2&"' where id = "&A2&";" --excel用
--05_流入登録日時（マーケ遡及）
update inflows set registered_time = '' where id = xx;
="update inflows set registered_time = '"&TEXT(B2, "yyyy-MM-dd")&" "&TEXT(C2, "hh:mm:ss")&"' where id = "&A2&";" --excel用


--確認--
--01_流入店舗用（流入作成）
="select id, customer_link_id, registered_time, master_inflow_type_id, master_campaign_id, is_handling_unrequired, created_at, updated_at from inflows where customer_link_id in ("&A14&");" --excel用
--02_流入cid（マーケ遡及）
select id, master_campaign_id from inflows where id in ();
="select id, master_campaign_id from inflows where id in ("&E1&");"
--03_流入sid（マーケ遡及）
select id, session_id from inflows where id in ();
="select id, session_id from inflows where id in ("&E1&");"
--04_流入流入種別（マーケ遡及）
select id, master_inflow_type_id from inflows where id in ();
="select id, master_inflow_type_id from inflows where id in ("&E1&");"
--05_流入登録日時（マーケ遡及）
select id, registerd_time from inflows where id in ();
="select id, registered_time from inflows where id in ("&E1&");"

--11_マーケ遡及まとめ_02,03,04,05
select id, master_campaign_id, session_id, master_inflow_type_id, registered_time from inflows where id in ();
=textjoin(",",true, A2:A)
="select id, master_campaign_id, session_id, master_inflow_type_id, registered_time, 'キャンペーンid' as 変更点 from inflows where id in ("&G1&")"
="select id, master_campaign_id, session_id, master_inflow_type_id, registered_time, 'セッションid' as 変更点 from inflows where id in ("&G1&")"
="select id, master_campaign_id, session_id, master_inflow_type_id, registered_time, '流入種別' as 変更点 from inflows where id in ("&G1&")"
="select id, master_campaign_id, session_id, master_inflow_type_id, registered_time, '流入登録日時' as 変更点 from inflows where id in ("&G1&")"
