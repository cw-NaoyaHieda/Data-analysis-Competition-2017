--会計明細から個別のアイテムが一致しているIDを抜き出す
DROP VIEW IF EXISTS  ID_LIST_item;

CREATE VIEW ID_LIST_item
AS
SELECT  
	henpin_line_id,
	hanbai_receipt,
	hanbai_line_id,
	hanbai_in_tax_oneitem AS in_tax_oneitem,
	tax_oneitem,
	1 AS item_num
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
			A.in_tax,
			A.trans_category,
			A.pos_staff,
			A.regi_staff,
			A.cash,
			A.credit,
			A.ec_money,
			A.item_num,
			B.line_id AS henpin_line_id, -- 会計明細iD
			B.item_treat,
			B.in_tax AS henpin_in_tax_oneitem,
			B.discount,
			B.product_id
		FROM
		receipt_henpin_syori AS A
		LEFT JOIN(
			SELECT
				* 
			FROM
				line_henpin_syori
			) AS B
			ON A.receipt_id = B.receipt_id
		WHERE
			trans_category = '返品') AS C
			-- カテゴリーが返品という前提で会計IDをkeyとして会計履歴と会計明細をがっちゃん
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
				B.in_tax AS hanbai_in_tax_oneitem,
				B.tax AS tax_oneitem,
				B.discount,
				B.product_id
			FROM
				receipt_henpin_syori AS A
				LEFT JOIN(
					SELECT
						*
					FROM
						line_henpin_syori
				) AS B
				ON A.receipt_id = B.receipt_id
			WHERE
				trans_category = '販売'	) AS D
				ON C.store_id = D.store_id AND C.customer_id = D.customer_id
				AND C.product_id = D.product_id AND ABS(henpin_in_tax_oneitem) = hanbai_in_tax_oneitem
				AND ABS(C.discount) = D.discount AND (C.dt > D.dt OR (C.dt = D.dt AND C.t > D.t))
			) AS E
			
WHERE rk = 1 AND hanbai_receipt IS NOT NULL
-- 一致するもので create view

-- WHERE rk = 1 AND hanbai_receipt IS NULL;
--

	