-- テーブルの複製
--DROP TABLE IF EXISTS receipt_henpin_syori CASCADE;
-- CREATE TABLE receipt_henpin_syori AS SELECT * FROM receipt_1;

-- 手動 while loop 笑
-- 第一工程
DROP TABLE IF EXISTS id_all_fit CASCADE;
CREATE TEMPORARY TABLE id_all_fit
AS SELECT 
	MAX(henpin) AS henpin_receipt,
	hanbai AS hanbai_receipt
FROM(
	SELECT
		A.receipt_id AS henpin,
		MAX(B.receipt_id) AS hanbai
	FROM(
		SELECT 
			*
		FROM 
			receipt_henpin_syori
		WHERE
			TRIM(trans_category) = '返品') AS A
		LEFT JOIN(
			SELECT 
				*
			FROM 
				receipt_henpin_syori
			WHERE
				TRIM(trans_category) = '販売') AS B
		ON A.store_id = B.store_id AND A.customer_id = B.customer_id
		AND ABS(A.in_tax) = B.in_tax
		AND (A.dt > B.dt OR A.dt = B.dt)

	GROUP BY A.receipt_id) AS C 
GROUP BY hanbai
HAVING hanbai IS NOT NULL;

-- 第二工程
DELETE FROM receipt_henpin_syori AS A
USING id_all_fit AS B
WHERE A.receipt_id = B.henpin_receipt
      OR A.receipt_id = B.hanbai_receipt;

--CREATE TEMPORARY TABLE id_list_1 AS SELECT * FROM id_all_fit;
--CREATE TEMPORARY TABLE id_list_2 AS SELECT * FROM id_all_fit;
--CREATE TEMPORARY TABLE id_list_3 AS SELECT * FROM id_all_fit;

SELECT * FROM id_all_fit;