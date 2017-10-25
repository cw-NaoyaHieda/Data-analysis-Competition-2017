-- 前処理
UPDATE receipt_1
SET customer_id = -1
WHERE customer_id IS NULL;

