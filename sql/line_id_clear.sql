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
	simei
FROM
	line_1
	left outer join
	id_list
		on line_1.line_id = id_list.henpin_line_id
		or line_1.line_id = id_list.hanbai_line_id
	where
	id_list.henpin_line_id is NULL

		