SELECT
	store_name,
	sex,
	birth_age,
	count(*)
FROM
	customer_2
LEFT JOIN
	store_1
ON
	customer_2.first_store = store_1.store_id
GROUP BY
	store_name,sex,birth_age
ORDER BY
	store_name,sex,birth_age