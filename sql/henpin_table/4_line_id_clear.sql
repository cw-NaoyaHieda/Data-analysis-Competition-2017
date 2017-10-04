DROP TABLE IF EXISTS  line_henpin_syori_fin;

CREATE TABLE line_henpin_syori_fin
-- アイテムごとの返品で抜き出したIDを消去する phase2
AS 
SELECT
 	line_id,
	receipt_id,
	item_treat,
	in_tax,
	discount,
	tax,
	product_id,
	staff_id,
	simei,
	CASE 
	   WHEN in_tax < 0 THEN '入力ミス'
	   WHEN in_tax >= 0 THEN '販売'
	   END AS trans_category
FROM
	line_henpin_syori
	left outer join
	id_list_item
		on line_henpin_syori.line_id = id_list_item.henpin_line_id
		or line_henpin_syori.line_id = id_list_item.hanbai_line_id
	where
	id_list_item.henpin_line_id is NULL

		