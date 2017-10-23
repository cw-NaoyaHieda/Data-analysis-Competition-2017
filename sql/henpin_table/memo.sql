SELECT
	MAX(dt),
	MIN(dt),
	COUNT(dt),
	COUNT(A.receipt_id),
	MAX(dt) - MIN(dt)
FROM 
	receipt_henpin_syori_fin AS A
	INNER JOIN line_henpin_syori_fin AS B
	ON A.receipt_id = B.receipt_id
WHERE
	--B.line_id = 3859766
	--OR B.line_id = 3217598
	A.customer_id = 3
	-- A.customer_id = 8318
	--A.receipt_id = 1988341
	--OR A.receipt_id = 1987978
	-- OR A.receipt_id = 1600950
	 --A.trans_category = '返品'
	-- A.dt = '2015-11-30'
--GROUP BY A.customer_id


SELECT *
FROM 
	receipt_henpin_syori_fin AS A
	INNER JOIN line_henpin_syori_fin AS B
	ON A.receipt_id = B.receipt_id
WHERE
	--B.line_id = 3859766
	--OR B.line_id = 3217598
	A.customer_id = 3