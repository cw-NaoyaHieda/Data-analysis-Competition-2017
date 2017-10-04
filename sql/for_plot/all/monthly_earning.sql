SELECT
	date_part('year',receipt_henpin_syori.dt) AS year,
	date_part('month',receipt_henpin_syori.dt) AS month,
	count(receipt_henpin_syori.receipt_id) AS customer_count,
	sum(line_henpin_syori.in_tax - line_henpin_syori.tax) AS earn,
	sum(CASE WHEN item_treat = '施術販売' THEN line_henpin_syori.in_tax - line_henpin_syori.tax ELSE 0 END) AS service,
	sum(CASE WHEN item_treat = '物販商品' THEN line_henpin_syori.in_tax - line_henpin_syori.tax ELSE 0 END) AS item,
	sum(line_henpin_syori.in_tax - line_henpin_syori.tax) / count(receipt_henpin_syori.receipt_id) AS one_person
FROM
	receipt_henpin_syori
LEFT JOIN
	line_henpin_syori
ON
	receipt_henpin_syori.receipt_id = line_henpin_syori.receipt_id
GROUP BY
	date_part('year',receipt_henpin_syori.dt),date_part('month',receipt_henpin_syori.dt)
ORDER BY
	year,month
	
	