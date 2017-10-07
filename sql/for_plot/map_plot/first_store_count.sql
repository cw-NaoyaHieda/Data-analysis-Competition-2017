SELECT
	zip_geocodes_over5.zip_code,
	customer_2.first_store,
	count(*),
	AVG(longitude) AS long,
	AVG(latitude) AS lat
	
FROM
	customer_2
LEFT JOIN
	zip_geocodes_over5
ON
	SUBSTR(TRIM(CAST(customer_2.zip_code AS character(10))),1,5) = zip_geocodes_over5.zip_code
GROUP BY
	zip_geocodes_over5.zip_code , customer_2.first_store
HAVING
	zip_geocodes_over5.zip_code IS NOT NULL
ORDER BY
	customer_2.first_store
