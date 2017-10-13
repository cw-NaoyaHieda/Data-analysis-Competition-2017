SELECT
	*
FROM 
	receipt_henpin_syori AS A
	INNER JOIN line_henpin_syori AS B
	ON A.receipt_id = B.receipt_id
	-- receipt_henpin_syori AS A
WHERE
	--B.line_id = 3220403
	--OR B.line_id = 3217598
	-- A.customer_id = 6137
	-- A.customer_id = 8318
	A.receipt_id = 1600950
	-- OR A.receipt_id = 1602181
	-- OR A.receipt_id = 1600950
	 --A.trans_category = '返品'
	-- A.dt = '2015-11-30'