CREATE VIEW staff_monthly AS 

SELECT 
	regi_staff, date_trunc('month',dt), COUNT(*)
FROM 
	receipt_1
GROUP BY
	regi_staff, date_trunc('month',dt)
ORDER BY
	regi_staff, date_trunc('month',dt);