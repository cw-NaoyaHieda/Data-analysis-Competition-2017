SELECT
	sex,
	birth_age,
	count(*)
FROM
	customer_2
GROUP BY
	sex,birth_age
ORDER BY
	sex,birth_age