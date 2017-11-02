SELECT
	B.store_id,
	D.zip_code,
	SUM(in_tax) AS sum,
	AVG(longitude) AS long,
	AVG(latitude) AS lati
FROM
	(SELECT
		receipt_id,
		in_tax
	FROM
		line_henpin_syori_fin
	) AS A
LEFT JOIN
	(SELECT
		receipt_id,
		store_id,
		dt,
		t,
		customer_id
	FROM
		receipt_1
	) AS B
ON
	A.receipt_id = B.receipt_id
LEFT JOIN
	(SELECT
		zip_code,
		customer_id
	FROM
		customer_2
	) AS C
ON
	B.customer_id = C.customer_id

LEFT JOIN
	(SELECT
		zip_code,
		longitude,
		latitude 
	FROM
		zip_geocodes_over5
	) AS D
ON
	SUBSTR(TRIM(CAST(C.zip_code AS character(10))),1,5) = D.zip_code
GROUP BY
	B.store_id,D.zip_code
ORDER BY
	store_id,sum