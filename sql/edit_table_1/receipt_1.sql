DROP TABLE IF EXISTS  public.receipt_1;

CREATE TABLE receipt_1 AS

SELECT
	CAST(rireki.accounting_id AS integer) AS receipt_id,
	store_id_num AS store_id,
	accounting_date AS dt,
	accounting_time AS t,
	customer_id,
	tax AS in_tax,
	tax_only AS tax,
	trans_category,
	CASE WHEN TRIM(pos_staff) = '#N/A' THEN NULL ELSE CAST(pos_staff AS integer) END AS pos_staff,
	CASE WHEN TRIM(accounting_staff) = '#N/A' THEN NULL ELSE CAST(accounting_staff AS integer) END AS regi_staff,
	simei,
	syouhinkenn_money AS coupon,
	syouhinkenn_maisuu AS counpon_num,
	genkin AS cash,
	credit,
	ec_money,
	urikake,
	tasya_syouhinkenn_money AS other_coupon,
	tasya_syouhinkenn_maisuu AS other_coupon_num,
	sum_syouhikenn AS sum_coupon_num,
	syouhinkenn_id AS coupon_id,
	use_point,
	use_point_class,
	point_grant,
	point_balance,
	ruiseki AS cs_point,
	CAST(item_num AS integer) AS item_num
FROM
	rireki
	LEFT JOIN(
		SELECT
			*
			,CAST(ROW_NUMBER() OVER (ORDER BY store_id) AS integer) AS store_id_num
		FROM
			store
	) AS A
	ON  rireki.store_id = A.store_id
	LEFT JOIN(
		SELECT
			accounting_id,
			count(*) AS item_num
		FROM
			meisai
		GROUP BY
			accounting_id
	) AS B
	ON CAST(rireki.accounting_id AS integer) = B.accounting_id
WHERE NOT B.item_num IS NULL
