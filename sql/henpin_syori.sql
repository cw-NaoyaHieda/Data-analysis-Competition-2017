SELECT
	henpin_receipt,
	henpin_line_id,
	hanbai_receipt,
	hanbai_line_id
FROM
	(SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY henpin_line_id ORDER BY D.dt DESC) AS rk
	FROM
	(SELECT
		A.receipt_id AS henpin_receipt,
		A.store_id,
		A.dt,
		A.t,
		A.customer_id,
		A.in_tax,
		A.trans_category,
		A.pos_staff,
		A.regi_staff,
		A.cash,
		A.credit,
		A.ec_money,
		A.item_num,
		B.line_id AS henpin_line_id,
		B.item_treat,
		B.in_tax,
		B.discount,
		B.product_id
	FROM
		receipt_1 AS A
		LEFT JOIN(
			SELECT
				*
			FROM
				line_1
		) AS B
		ON A.receipt_id = B.receipt_id
	WHERE
		trans_category = '返品') AS C
	LEFT JOIN(
	SELECT
		A.receipt_id AS hanbai_receipt,
		A.store_id,
		A.dt,
		A.t,
		A.customer_id,
		A.in_tax,
		A.cash,
		A.credit,
		A.ec_money,
		A.item_num,
		B.line_id AS hanbai_line_id,
		B.item_treat,
		B.in_tax AS in_tax_oneitem,
		B.discount,
		B.product_id
	FROM
		receipt_1 AS A
		LEFT JOIN(
			SELECT
				*
			FROM
				line_1
		) AS B
		ON A.receipt_id = B.receipt_id
	WHERE
		trans_category = '販売'	) AS D
		ON	C.store_id = D.store_id AND C.customer_id = D.customer_id
			AND C.product_id = D.product_id AND (C.dt > D.dt OR (C.dt = D.dt AND C.t > D.t))
	) AS E
WHERE rk = 1 AND hanbai_receipt IS NULL

