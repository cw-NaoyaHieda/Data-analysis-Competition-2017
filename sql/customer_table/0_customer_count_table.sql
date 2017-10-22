-- 検証用
-- 調査は大体出来た
CREATE TEMPORARY TABLE id_set AS
SELECT D.receipt_id
FROM receipt_henpin_syori_fin AS D
INNER JOIN 
(SELECT
	A.receipt_id,
	--A.store_id,
	--A.dt,
	--A.t,
	--A.customer_id,
	SUM(B.in_tax) AS sum_money
FROM receipt_henpin_syori_fin AS A
	INNER JOIN(
		SELECT *
		FROM line_henpin_syori_fin
		WHERE item_treat = '施術販売' AND product_id != '70010001'
		AND product_id != '70010002' AND product_id != '70010003'
		AND product_id != '70010004' AND product_id != '70010005'
		AND product_id != '70010017' AND product_id != '70010019'
		AND product_id != '10010013') AS B
	ON A.receipt_id = B.receipt_id
	GROUP BY A.receipt_id,A.store_id,A.dt,A.t,A.customer_id) AS C
	ON D.receipt_id = C.receipt_id AND D.in_tax = C.sum_money

WHERE sum_money <= 0;

SELECT * 
FROM line_henpin_syori_fin AS A
INNER JOIN id_set AS B
ON A.receipt_id = B.receipt_id