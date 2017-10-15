SELECT
	henpin_receipt,
	
FROM 
	 line_1 AS A
	 LEFT JOIN(
		SELECT *
		FROM id_list_all
		) AS B
	ON A.receipt_id = B.henpin_receipt
	OR A.receipt_id = B.hanbai_receipt
