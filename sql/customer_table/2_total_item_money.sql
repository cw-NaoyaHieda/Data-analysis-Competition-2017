-- 各顧客の店販購入金額
UPDATE customer_2 AS D
SET total_item_money = (
SELECT 
	money
FROM(
	SELECT customer_id, SUM(B.in_tax) AS money
	FROM receipt_henpin_syori_fin AS A
		INNER JOIN(
			SELECT *
			FROM line_henpin_syori_fin
			WHERE item_treat = '物販商品' ) AS B
		ON A.receipt_id = B.receipt_id		
	GROUP BY customer_id) AS C
WHERE D.customer_id = C.customer_id);

UPDATE customer_2
SET total_item_money = 0
WHERE total_item_money IS NULL;