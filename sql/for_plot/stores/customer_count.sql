SELECT
	store_name
	,sex
	,birth_age
	,count(*) AS count
FROM
	receipt_henpin_syori
LEFT JOIN
	customer_2
ON
	receipt_henpin_syori.customer_id = customer_2.customer_id
LEFT JOIN
	store_1
ON
	receipt_henpin_syori.store_id = store_1.store_id
GROUP BY
	store_name,receipt_henpin_syori.customer_id,sex,birth_age
ORDER BY
	store_name,count DESC