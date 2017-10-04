DROP TABLE gaiku_geocodes;
CREATE TABLE gaiku_geocodes (
pref_kanji varchar(36),
city_kanji varchar(128),
town_kanji varchar(128),
longitude numeric,
latitude numeric
)
;
insert into gaiku_geocodes (pref_kanji,city_kanji,town_kanji,longitude,latitude)
select 
pref_kanji,city_kanji,town_kanji,avg(longitude),avg(latitude)
from gaiku_infos
group by pref_kanji,city_kanji,town_kanji
;
DROP TABLE zip_geocodes;
CREATE TABLE zip_geocodes (
zip_code CHAR(7),
longitude numeric,
latitude numeric
);
insert into zip_geocodes (zip_code,longitude,latitude)
select 
postcode,longitude,latitude
from post_codes
left outer join gaiku_geocodes 
on post_codes.pref_kanji = gaiku_geocodes.pref_kanji
and post_codes.city_kanji = gaiku_geocodes.city_kanji
and post_codes.town_kanji = gaiku_geocodes.town_kanji
where gaiku_geocodes.town_kanji is not null
;