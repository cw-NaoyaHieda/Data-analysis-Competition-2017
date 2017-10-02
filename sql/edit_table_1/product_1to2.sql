UPDATE
	product_1
SET
	product_name = '新宿サウス店不明クーポン'
WHERE
	product_name = '#NAME?'; --商品名が#NAME?だったものを変更。
				 --商品カテゴリなどを参照し


ALTER TABLE product_1 RENAME TO product_2;