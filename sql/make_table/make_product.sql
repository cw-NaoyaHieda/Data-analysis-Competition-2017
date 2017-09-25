-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.product;

CREATE TABLE public.product
(

account_spec_product_id char(20),
product_category char(30),
category_id_1 int,
category_1 char(30),
category_id_2 int,
category_2 char(30),
product_name char(80),
abbreviation char(30),
non_tax int,
tax int,
minute int,
first_date date,
end_date date,
reservation_category char(30),
reservation_item char(30)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.customer
  OWNER TO postgres;