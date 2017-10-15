SELECT
	*
FROM 
	--receipt_henpin_syori AS A
	--INNER JOIN line_henpin_syori AS B
	--ON A.receipt_id = B.receipt_id
	receipt_1 AS A
	INNER JOIN line_1 AS B
	ON A.receipt_id = B.receipt_id
	-- receipt_henpin_syori AS A
WHERE
	--B.line_id = 3859766
	--OR B.line_id = 3217598
	-- A.customer_id = 6137
	-- A.customer_id = 8318
	A.receipt_id = 1988341
	OR A.receipt_id = 1987978
	-- OR A.receipt_id = 1600950
	 --A.trans_category = '返品'
	-- A.dt = '2015-11-30'