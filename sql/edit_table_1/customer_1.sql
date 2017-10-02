DROP TABLE IF EXISTS  public.customer_1;

CREATE TABLE customer_1 AS

SELECT
	CAST(customer_id AS integer) AS customer_id,
	first_year,
	store_id_num AS first_store,
	zip_code,
	dm,
	sex,
	CASE WHEN TRIM(birth_age) = '#VALUE!' THEN 0 ELSE CAST(birth_age AS integer) END AS birth_age,
	comment
FROM
	customer
	LEFT JOIN(
		SELECT
			CAST(ROW_NUMBER() OVER (ORDER BY store_id) AS integer) AS store_id_num,
			*
		FROM
			store
	) AS A
	ON customer.first_store = A.store_id
