-- 一応完成版
-- 合計金額, 税金, お金, クレジット, 電子マネー, 購入品目数については処理済
-- ポイントなどには一切触れていない

DROP TABLE IF EXISTS  receipt_henpin_syori_fin;

CREATE TABLE receipt_henpin_syori_fin

AS 
SELECT
 	receipt_id,
	store_id,
	dt,
	t,
	customer_id,
        CASE  
	  WHEN hanbai_receipt IS NOT NULL THEN in_tax - in_tax_oneitem
	  ELSE in_tax END AS in_tax,
	CASE
	  WHEN hanbai_receipt IS NOT NULL THEN tax - tax_oneitem
	  ELSE tax END AS tax,
	trans_category,
	pos_staff,
	regi_staff,
	simei,
	coupon,
	counpon_num,
	CASE
	  WHEN hanbai_receipt IS NOT NULL AND cash > 0 THEN cash - in_tax_oneitem
	  ELSE cash END AS cash,
	CASE
	  WHEN hanbai_receipt IS NOT NULL AND credit > 0 THEN credit - in_tax_oneitem
	  ELSE credit END AS credit,
	CASE
	  WHEN hanbai_receipt IS NOT NULL AND ec_money > 0 THEN ec_money - in_tax_oneitem
	  ELSE ec_money END AS ec_money,
	urikake,	
	other_coupon,
	other_coupon_num,
	sum_coupon_num,
	coupon_id,
	use_point,
	use_point_class,
	point_grant,
	point_balance,
	cs_point,
	CASE
	  WHEN hanbai_receipt IS NOT NULL THEN item_num - hanbai_item_num
	  ELSE item_num END AS item_num
FROM
	receipt_henpin_syori AS A
	LEFT JOIN(
		SELECT 
			hanbai_receipt,
			sum(in_tax_oneitem) AS in_tax_oneitem,
			sum(tax_oneitem) AS tax_oneitem,
			sum(item_num) AS hanbai_item_num
	
		 FROM 
			id_list_item
		 GROUP BY 
			hanbai_receipt
		) AS B
		ON A.receipt_id = B.hanbai_receipt
-- 返品は消去
WHERE
	trans_category = '販売'
