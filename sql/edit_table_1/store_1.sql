DROP TABLE IF EXISTS  public.store_1;

CREATE TABLE store_1 AS
SELECT
	CAST(ROW_NUMBER() OVER (ORDER BY store_id) AS integer) AS store_id,
	store_name,
 	CAST(latitude AS integer) AS lat,
 	CAST(longitude AS integer) AS long,
    floor AS f
FROM
	store;

INSERT INTO	store_1 (store_id,store_name,lat,long,f)
	VALUES	(0,'その他',NULL,NULL,NULL)
