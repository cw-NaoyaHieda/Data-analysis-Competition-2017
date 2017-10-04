DROP TABLE IF EXISTS  public.staff_1;

CREATE TABLE staff_1 AS

SELECT
	CAST( TRIM( staff_id ) AS integer) AS staff_id,
	CAST(store_id_num AS integer)
FROM
	staff
	LEFT JOIN
	(
		SELECT
			ROW_NUMBER() OVER (ORDER BY store_id) AS store_id_num,
			*
		FROM
			store
		UNION ALL
			VALUES (0,'他店舗','その他',0,0,NULL)
	) AS store_tmp
	ON staff.store_id = store_tmp.store_id
ORDER BY
	staff_id
OFFSET
	1;