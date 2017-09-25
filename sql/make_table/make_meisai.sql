-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.meisai;

CREATE TABLE public.meisai
(

meisai_id char(10),
accounting_id int,
specific_category char(5),
tax int,
waribiki int,
tax_only char(20),
specific_product_id char(20),
specific_staff_id char(10),
specific_simei char(3)

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.meisai
  OWNER TO postgres;
