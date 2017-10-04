DROP TABLE gaiku_infos;
CREATE TABLE gaiku_infos (
pref_kanji varchar(36),
city_kanji varchar(128),
town_kanji varchar(128),
number varchar(128),
coordinate_no char(4),
coordinate_x numeric,
coordinate_y numeric,
longitude numeric,
latitude numeric,
disp_flg char(1),
represent_flg char(1),
history_flg1 char(1),
history_flg2 char(1)
);
CREATE INDEX idx_pref ON gaiku_infos (
pref_kanji
);
CREATE INDEX idx_city ON gaiku_infos (
city_kanji
);
CREATE INDEX idx_town ON gaiku_infos (
town_kanji
);
CREATE INDEX idx_address ON gaiku_infos (
pref_kanji,city_kanji,town_kanji
);