DROP VIEW IF EXISTS customer_staff;
CREATE VIEW customer_staff AS
SELECT
	customer_id,
	MAX(rank) AS staff_num,
	SUM(pair_count) AS all_count,
	MAX(CASE rank WHEN 1 THEN regi_staff ELSE NULL END) AS main,
	MAX(CASE rank WHEN 1 THEN pair_count ELSE NULL END) AS main_count,
	MAX(CASE rank WHEN 2 THEN regi_staff ELSE NULL END) AS sub_staff,
	MAX(CASE rank WHEN 2 THEN pair_count ELSE NULL END) AS subcount,
	MAX(CASE rank WHEN 3 THEN regi_staff ELSE NULL END) AS sub_sub_staff,
	MAX(CASE rank WHEN 3 THEN pair_count ELSE NULL END) AS sub_sub_count
FROM(
	SELECT
		customer_id,
		regi_staff,
		count(*) AS pair_count,
		RANK() OVER(PARTITION BY customer_id ORDER BY count(*) DESC) AS rank
	FROM
		receipt_henpin_syori_fin
	GROUP BY
		customer_id,regi_staff
	ORDER BY
		pair_count DESC) AS A
GROUP BY
	customer_id
ORDER BY
	main_count DESC
