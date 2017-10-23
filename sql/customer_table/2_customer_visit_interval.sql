-- 顧客の来店間隔を記録

-- ここ必ず消すこと!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ALTER TABLE customer_2 ADD COLUMN visit_interval INT;

UPDATE customer_2 AS E
SET visit_interval = (
SELECT 
	visit_interval
FROM(
	SELECT 
		C.customer_id,
		CASE COUNT(dt) WHEN '1' THEN NULL
		 ELSE (MAX(C.dt)-MIN(C.dt)) / (COUNT(dt)-1) END AS visit_interval
	FROM(
		SELECT 
			MAX(customer_id) AS customer_id,
			MAX(dt) AS dt
		FROM receipt_henpin_syori_fin AS A
		INNER JOIN(
		SELECT *
		FROM line_henpin_syori_fin
		WHERE item_treat = '施術販売' AND product_id != '70010001' AND product_id != '70010002' AND product_id != '70010003'
			AND product_id != '70010004' AND product_id != '70010005'
			AND product_id != '70010017' AND product_id != '70010019'
			AND product_id != '10010013') AS B
		ON A.receipt_id = B.receipt_id
		GROUP BY A.receipt_id) AS C
	GROUP BY C.customer_id
	ORDER BY C.customer_id) AS D
WHERE E.customer_id = D.customer_id);