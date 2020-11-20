select
'5月_20%' as キーワード
,d.created_at as 応対作成日時
,d.communication_id as コミュid
,d.id as 応対記録id
,dt.name as 応対種別
--,d.dialogue_text as 応対内容
,c.registered_time as 流入登録日時
from dialogues d
inner join master_dialogue_types dt on dt.id = d.master_dialogue_type_id
inner join communications c on c.id = d.communication_id
where d.created_at between '2020-05-01' and '2020-06-01'
and (d.dialogue_text like '%20*%%' escape '*'
or d.dialogue_text like '%２０％%'
or d.dialogue_text like '%20％%')
