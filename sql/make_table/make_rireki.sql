-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.rireki;

CREATE TABLE public.rireki
(

accounting_id char(20),
store_id char(4),
accounting_date date,
accounting_time time,
customer_id int,
tax int,
tax_only int,
trans_category char(10),
pos_staff char(10),
accounting_staff char(10),
simei char(10),
syouhinkenn_money int,
syouhinkenn_maisuu int,
genkin int,
credit int,
ec_money int,
urikake int,
tasya_syouhinkenn_money int,
tasya_syouhinkenn_maisuu int,
sum_syouhikenn int,
syouhinkenn_id char(10),
use_point int,
use_point_class char(10),
point_grant int,
point_balance int,
ruiseki int

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.meisai
  OWNER TO postgres;
