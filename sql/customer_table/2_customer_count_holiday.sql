------------------ 土日について -------------------
-- 祝日は入ってないよ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- 13時までに来店した回数を記録
UPDATE customer_2 AS E
SET morning_count_holiday = (
SELECT 
	count
FROM(
	SELECT C.customer_id,COUNT(*) AS count
	FROM(
		SELECT MAX(customer_id) AS customer_id
		FROM receipt_henpin_syori_fin AS A
		INNER JOIN(
		SELECT *
		FROM line_henpin_syori_fin
		WHERE item_treat = '施術販売' AND product_id != '70010001' AND product_id != '70010002' AND product_id != '70010003'
			AND product_id != '70010004' AND product_id != '70010005'
			AND product_id != '70010017' AND product_id != '70010019'
			AND product_id != '10010013') AS B
		ON A.receipt_id = B.receipt_id
		WHERE A.t < '13:00:00' AND A.day >= 5 
		GROUP BY A.receipt_id) AS C
	GROUP BY C.customer_id) AS D
WHERE E.customer_id = D.customer_id);

-- 13時から18時までに来店した回数を記録SS
UPDATE customer_2 AS E
SET evening_count_holiday = (
SELECT 
	count
FROM(
	SELECT C.customer_id,COUNT(*) AS count 
	FROM(
		SELECT MAX(customer_id) AS customer_id
		FROM receipt_henpin_syori_fin AS A
	    INNER JOIN(
		SELECT *
		FROM line_henpin_syori_fin
		WHERE item_treat = '施術販売' AND product_id != '70010001' AND product_id != '70010002' AND product_id != '70010003'
			AND product_id != '70010004' AND product_id != '70010005'
			AND product_id != '70010017' AND product_id != '70010019'
			AND product_id != '10010013') AS B
		ON A.receipt_id = B.receipt_id
		WHERE (A.t BETWEEN '13:00:00' AND '18:00:00') AND A.day >= 5
		GROUP BY A.receipt_id) AS C
	GROUP BY C.customer_id) AS D
WHERE E.customer_id = D.customer_id);

-- 18時以降に来店した回数を記録
UPDATE customer_2 AS E
SET night_count_holiday = (
SELECT 
	count
FROM(
	SELECT C.customer_id,COUNT(*) AS count
	FROM(
		SELECT MAX(customer_id) AS customer_id
		FROM receipt_henpin_syori_fin AS A
		INNER JOIN(
		SELECT *
		FROM line_henpin_syori_fin
		WHERE item_treat = '施術販売' AND product_id != '70010001' AND product_id != '70010002' AND product_id != '70010003'
			AND product_id != '70010004' AND product_id != '70010005'
			AND product_id != '70010017' AND product_id != '70010019'
			AND product_id != '10010013') AS B
		ON A.receipt_id = B.receipt_id
		WHERE A.t > '18:00:00' AND A.day >= 5
		GROUP BY A.receipt_id) AS C
	GROUP BY C.customer_id) AS D
WHERE E.customer_id = D.customer_id);

-- 空欄を0で埋める
UPDATE customer_2 SET morning_count_holiday = 0 WHERE morning_count_holiday IS NULL;
UPDATE customer_2 SET evening_count_holiday=0 WHERE evening_count_holiday IS NULL;
UPDATE customer_2 SET night_count_holiday=0 WHERE night_count_holiday IS NULL;
