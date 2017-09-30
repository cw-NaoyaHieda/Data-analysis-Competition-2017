DROP TABLE IF EXISTS  public.line_1;

CREATE TABLE line_1 AS

SELECT
	CAST( TRIM(meisai_id) AS integer) AS line_id,
	accounting_id AS receipt_id,
	specific_category AS item_treat,
	tax AS in_tax,
	waribiki AS discount,
	CAST(tax_only AS integer) AS tax,
	specific_product_id AS product_id,
	specific_staff_id AS staff_id,
	specific_simei AS simei
FROM
	meisai
