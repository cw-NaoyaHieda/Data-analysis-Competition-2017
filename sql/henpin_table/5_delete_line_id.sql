-- 残ったもの全て削除する
DELETE FROM 
	line_henpin_syori_fin
WHERE
	trans_category = '入力ミス';
	