-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  receipt_henpin_syori;

CREATE TABLE
	receipt_henpin_syori
-- 返品で抜き出したIDを消去する
AS SELECT
 	receipt_id,
	store_id,
	dt,
	t,
	customer_id,
	in_tax,
	tax,
	CASE trans_category WHEN '返品' THEN '入力ミス' END AS trans_category ,
	pos_staff,
	regi_staff,
	simei,
	coupon,
	counpon_num,
	cash,
	credit,
	ec_money,	
	urikake,	
	other_coupon,
	other_coupon_num,
	sum_coupon_num,
	coupon_id,
	use_point,
	use_point_class,
	point_grant,
	point_balance,
	cs_point	,
	item_num
FROM
	receipt_1
	left outer join
	id_list
		on receipt_1.receipt_id = id_list.henpin_receipt
		or receipt_1.receipt_id = id_list.hanbai_receipt
	where
		id_list.henpin_receipt is NULL

		