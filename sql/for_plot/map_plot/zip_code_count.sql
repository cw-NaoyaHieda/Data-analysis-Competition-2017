SELECT
	zip_code,
	count(*)
FROM
	customer_2
GROUP BY
	zip_code