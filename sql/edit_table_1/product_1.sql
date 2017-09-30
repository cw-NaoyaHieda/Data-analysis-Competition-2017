DROP TABLE IF EXISTS  public.product_1;

CREATE TABLE product_1 AS
SELECT
	account_spec_product_id  AS product_id,
	product_category,
	category_id_1,
	category_1,
	CASE WHEN category_1 = '廃棄' THEN 900001
	     WHEN account_spec_product_id = '9000000002' THEN '900000'
	     ELSE category_id_2 END AS category_id_2,
	CASE WHEN category_1 = '廃棄' THEN '廃棄'
	     WHEN account_spec_product_id = '9000000002' THEN '特別セット'
	     ELSE category_2 END AS category_2,
	CASE WHEN account_spec_product_id = '9000000002' THEN 'ﾌｪｲｼｬﾙ+ﾍｯﾄﾞﾏｯｻｰｼﾞ+ﾏｯｻｰｼﾞｼｬﾝﾌﾟｰ+眉ｶｯﾄ+ｶｯﾄ' END AS product_name,
	non_tax,
	tax AS in_tax,
	minute AS treat_time,
	first_date,
	end_date
FROM
	product
