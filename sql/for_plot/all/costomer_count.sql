SELECT
	sex
	,birth_age
	,count(*) AS count
FROM
	receipt_henpin_syori
LEFT JOIN
	customer_2
ON
	receipt_henpin_syori.customer_id = customer_2.customer_id
GROUP BY
	receipt_henpin_syori.customer_id,sex,birth_age
ORDER BY
	count DESC