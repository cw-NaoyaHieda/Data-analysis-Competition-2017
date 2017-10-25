-- 会計履歴から会計IDごとに合計金額が一致しているIDを抜き出す

DROP VIEW IF EXISTS  ID_LIST_all;

CREATE VIEW ID_LIST_all
AS 

SELECT
	henpin_receipt,
	henpin_line_id,
	hanbai_receipt,
	hanbai_line_id
FROM
	(SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY henpin_line_id ORDER BY D.dt DESC) AS rk
		-- ROW_NUMBER() 連番を割り振る
		-- PARTATION BY 会計明細ID内で
		-- ORDER BY 日付順
		-- DESK:降順,ASC:昇順
	FROM
		(SELECT
			A.receipt_id AS henpin_receipt, -- 会計iD
			A.store_id,
			A.dt,
			A.t,
			A.customer_id,
			A.in_tax AS in_tax_all,
			A.trans_category,
			A.pos_staff,
			A.regi_staff,
			A.cash,
			A.credit,
			A.ec_money,
			A.item_num,
			B.line_id AS henpin_line_id, -- 会計明細iD
			B.item_treat,
			B.in_tax,
			B.discount,
			B.product_id
		FROM(
			SELECT
				receipt_1.receipt_id,
				receipt_1.store_id,
				receipt_1.dt,
				receipt_1.t,
				CASE 
				   WHEN receipt_1.customer_id IS NULL THEN -1
				   ELSE receipt_1.customer_id
				   END AS customer_id,
				receipt_1.in_tax,
				receipt_1.trans_category,
				receipt_1.pos_staff,
				receipt_1.regi_staff,
				receipt_1.cash,
				receipt_1.credit,
				receipt_1.ec_money,
				receipt_1.item_num
			FROM
				receipt_1
			)AS A
		
		LEFT JOIN(
			SELECT
				* 
			FROM
				line_1
			) AS B
			ON A.receipt_id = B.receipt_id
		WHERE
			TRIM(trans_category) = '返品') AS C
			-- カテゴリーが返品という前提で会計IDをkeyとして会計履歴と会計明細をがっちゃん
	LEFT JOIN(
		SELECT
			A.receipt_id AS hanbai_receipt,
			A.store_id,
			A.dt,
			A.t,
			A.customer_id,
			A.in_tax AS in_tax_all,
			A.cash,
			A.credit,
			A.ec_money,
			A.item_num,
			B.line_id AS hanbai_line_id,
			B.item_treat,
			B.in_tax,
			B.discount,
			B.product_id
		FROM(
			SELECT
				receipt_1.receipt_id,
				receipt_1.store_id,
				receipt_1.dt,
				receipt_1.t,
				CASE 
				   WHEN receipt_1.customer_id IS NULL THEN -1
				   ELSE receipt_1.customer_id
				   END AS customer_id,
				receipt_1.in_tax,
				receipt_1.trans_category,
				receipt_1.pos_staff,
				receipt_1.regi_staff,
				receipt_1.cash,
				receipt_1.credit,
				receipt_1.ec_money,
				receipt_1.item_num
			FROM
				receipt_1 
			)AS A
			LEFT JOIN(
				SELECT
					*
				FROM
					line_1
			) AS B
			ON A.receipt_id = B.receipt_id
		WHERE
			TRIM(trans_category) = '販売'	) AS D
			ON C.store_id = D.store_id AND C.customer_id = D.customer_id
			AND ABS(C.in_tax_all) = D.in_tax_all
			AND (C.dt > D.dt OR C.dt = D.dt)
		) AS E
	WHERE rk = 1 AND hanbai_receipt IS NOT NULL;
	-- 一致するもので create view

	-- WHERE rk = 1 AND hanbai_receipt IS NULL
	-- 一致しないもの45件
