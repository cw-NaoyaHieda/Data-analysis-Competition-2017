-- テーブルの複製
DROP TABLE IF EXISTS line_henpin_syori CASCADE;
CREATE TABLE line_henpin_syori AS 
SELECT 
	A.line_id,
	A.receipt_id,
	A.item_treat,
	A.in_tax,
	A.discount,
	A.tax,
	A.product_id,
	A.staff_id,
	A.simei
FROM line_1 AS A

INNER JOIN(
	SELECT
		*
	FROM
		receipt_henpin_syori
	) AS B
	ON A.receipt_id = B.receipt_id
