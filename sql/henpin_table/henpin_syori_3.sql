-- カテゴリーが返品のものを削除
DROP TABLE IF EXISTS receipt_henpin_syori_fin;
CREATE TABLE receipt_henpin_syori_fin AS 
SELECT *
FROM receipt_henpin_syori
WHERE trans_category = '販売';

--会計履歴の金額の一致をみる
DROP TABLE IF EXISTS line_henpin_syori_fin;
CREATE TABLE line_henpin_syori_fin AS 
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
FROM line_henpin_syori AS A

INNER JOIN(
	SELECT
		*
	FROM
		receipt_henpin_syori_fin
	) AS B
	ON A.receipt_id = B.receipt_id;