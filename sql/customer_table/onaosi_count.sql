-- お直し回数カウント
UPDATE customer_2 AS E
SET remake_count = (
SELECT 
	count
FROM(
	SELECT C.customer_id,COUNT(*) as count
	FROM(
		SELECT MAX(customer_id) AS customer_id
		FROM receipt_henpin_syori_fin AS A
		INNER JOIN(
		SELECT receipt_id,product_id
		FROM line_henpin_syori_fin
		WHERE product_id = '70010001' OR product_id = '70010002' 
			OR product_id = '70010003' OR product_id = '70010004' 
			OR product_id = '70010005' OR product_id = '70010017' 
			OR product_id = '70010019' OR product_id = '10010013' ) AS B
			ON A.receipt_id = B.receipt_id
		GROUP BY A.receipt_id) AS C
	GROUP BY C.customer_id) AS D
WHERE E.customer_id = D.customer_id);

-- 空欄に0を埋める
UPDATE customer_2
SET remake_count = 0
WHERE remake_count IS NULL;

