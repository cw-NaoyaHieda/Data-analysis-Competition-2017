SELECT 
	in_tax,
	henpin_in_tax 
FROM 
	receipt_1 AS A,id_list_1 AS B

WHERE 
	A.receipt_id = B.henpin_receipt

		