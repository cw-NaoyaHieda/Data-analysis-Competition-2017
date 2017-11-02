SELECT
	store_1.store_name,
	date_part('year',receipt_henpin_syori.dt) AS year,
	date_part('month',receipt_henpin_syori.dt) AS month,
	count(receipt_henpin_syori.receipt_id) AS customer_count,
	sum(line_henpin_syori_fin.in_tax - line_henpin_syori_fin.tax) AS earn,
	sum(CASE WHEN item_treat = '施術販売' THEN line_henpin_syori_fin.in_tax - line_henpin_syori_fin.tax ELSE 0 END) AS service,
	sum(CASE WHEN item_treat = '物販商品' THEN line_henpin_syori_fin.in_tax - line_henpin_syori_fin.tax ELSE 0 END) AS item,
	sum(line_henpin_syori_fin.in_tax - line_henpin_syori_fin.tax) / count(receipt_henpin_syori.receipt_id) AS one_person
FROM
	receipt_henpin_syori
LEFT JOIN
	line_henpin_syori_fin
ON
	receipt_henpin_syori.receipt_id = line_henpin_syori_fin.receipt_id
LEFT JOIN
	store_1
ON
	receipt_henpin_syori.store_id = store_1.store_id
GROUP BY
	date_part('year',receipt_henpin_syori.dt),date_part('month',receipt_henpin_syori.dt),store_1.store_name
ORDER BY
	store_1.store_name,year,month
	
	