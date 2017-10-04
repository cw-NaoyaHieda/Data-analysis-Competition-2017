SELECT
	*
FROM 
	receipt_1 AS A
	LEFT JOIN
		line_1 AS B
	ON A.receipt_id = B.receipt_id
	-- line_henpin_syori
WHERE
	A.receipt_id = 1580598 OR A.receipt_id = 1580595 OR A.receipt_id = 1580596