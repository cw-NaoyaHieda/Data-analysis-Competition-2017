SELECT
	line_henpin_syori_fin.product_id,
	product_2.product_name,
	count(*) AS count
FROM
	line_henpin_syori_fin
LEFT JOIN
	product_2
ON
	line_henpin_syori_fin.product_id = product_2.product_id
WHERE
	trans_category = '販売'
GROUP BY
	line_henpin_syori_fin.product_id,product_2.product_name
ORDER BY
	count DESC