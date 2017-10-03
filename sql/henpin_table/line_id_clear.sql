-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  line_henpin_syori;

CREATE TABLE
	line_henpin_syori
-- 返品で抜き出したIDを消去する
AS SELECT
 	line_id,
	receipt_id,
	item_treat,
	in_tax,
	discount,
	tax,
	product_id,
	staff_id,
	simei,
	-- 入力ミスと販売を記録する列を追加,入力ミスが52個で一致することは調査済み
	CASE 
	   WHEN in_tax < 0 THEN '入力ミス'
	   WHEN in_tax >= 0 THEN '販売'
	   END AS trans_category
FROM
	line_1
	left outer join
	id_list
		on line_1.line_id = id_list.henpin_line_id
		or line_1.line_id = id_list.hanbai_line_id
	where
	id_list.henpin_line_id is NULL

		