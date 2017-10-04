SELECT
	SUBSTR(CAST(customer.zip_code AS CHARACTER(7)),1,5),
	zip_geocodes_over5.zip_code,
	AVG(longitude),
	AVG(latitude),
	SUM(count)
FROM
	(
	SELECT
		zip_code,
		count(*) AS count
	FROM
		customer_2
	GROUP BY
		zip_code
	) AS customer
LEFT JOIN
	zip_geocodes_over5
ON
	SUBSTR(CAST(customer.zip_code AS CHARACTER(7)),1,5) = zip_geocodes_over5.zip_code
GROUP BY
	SUBSTR(CAST(customer.zip_code AS CHARACTER(7)),1,5),
	zip_geocodes_over5.zip_code