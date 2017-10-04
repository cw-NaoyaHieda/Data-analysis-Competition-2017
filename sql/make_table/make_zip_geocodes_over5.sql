DROP TABLE IF EXISTS zip_geocodes_over5;
CREATE TABLE zip_geocodes_over5 (
zip_code CHAR(5),
longitude NUMERIC,
latitude NUMERIC
);
INSERT INTO zip_geocodes_over5 (zip_code,longitude,latitude)
SELECT 
SUBSTR(post_codes.postcode,1,5) as post_code_over5,AVG(longitude),AVG(latitude)
FROM post_codes
LEFT JOIN gaiku_geocodes 
ON post_codes.pref_kanji = gaiku_geocodes.pref_kanji
AND post_codes.city_kanji = gaiku_geocodes.city_kanji
--AND post_codes.town_kanji = gaiku_geocodes.town_kanji
WHERE
	gaiku_geocodes.town_kanji IS NOT NULL
GROUP BY
	SUBSTR(post_codes.postcode,1,5);
