--customer_1の後に実行
UPDATE 
	customer_1 
SET 
	birth_age = NULL
WHERE
	birth_age > 2020; --未来で生まれてる顧客の誕生年代をNULLに


UPDATE
	customer_1
SET
	first_year = NULL
WHERE
	first_year < 1978; --日本進出の前に初回来店はおかしいのでNULL



UPDATE
	customer_1
SET
	first_year = NULL,
	birth_age = NULL
WHERE
	birth_age > first_year; --誕生年代が2010年で初回来店年が1999年の人、どちらの年もNULLに