-- customer_idで降順並び替え
DROP TABLE IF EXISTS  customer_3;
CREATE TABLE customer_3 AS 
SELECT * FROM customer_2 ORDER BY customer_id DESC;