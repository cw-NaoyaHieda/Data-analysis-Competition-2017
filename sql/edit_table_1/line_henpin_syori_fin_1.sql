SELECT * from line_henpin_syori_fin 
where staff_id = '#N/A';

UPDATE
	line_henpin_syori_fin 
SET
	staff_id = NULL
WHERE
	staff_id = '#N/A'; --担当者idが#N/AだったところをNULLに


ALTER TABLE line_henpin_syori_fin RENAME TO line_henpin_syori_fin_1;