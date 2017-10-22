-- 曜日情報を追加する列を作成する
-- ALTER TABLE receipt_henpin_syori_fin ADD COLUMN day INT;

-- 曜日情報を追加する
-- 祝日どーする問題！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
UPDATE receipt_henpin_syori_fin AS A
SET day = (
	SELECT 
		EXTRACT(DOW FROM dt) AS day
	FROM 
		receipt_henpin_syori_fin AS B
	WHERE A.receipt_id = B.receipt_id);