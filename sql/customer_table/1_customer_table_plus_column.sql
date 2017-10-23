-- 削除フォーマット
-- ALTER TABLE customer_2 DROP COLUMN morning_count;

-- 顧客の時間別来店回数(施術)について
ALTER TABLE customer_2 ADD COLUMN morning_count_weekday INT;
ALTER TABLE customer_2 ADD COLUMN evening_count_weekday INT;
ALTER TABLE customer_2 ADD COLUMN night_count_weekday INT;
ALTER TABLE customer_2 ADD COLUMN morning_count_holiday INT;
ALTER TABLE customer_2 ADD COLUMN evening_count_holiday INT;
ALTER TABLE customer_2 ADD COLUMN night_count_holiday INT;

-- 顧客別お直し来店回数
ALTER TABLE customer_2 ADD COLUMN remake_count INT;

-- 顧客別商品購入金額
ALTER TABLE customer_2 ADD COLUMN total_item_money INT;
