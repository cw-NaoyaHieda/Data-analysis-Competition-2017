-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.customer;

CREATE TABLE public.customer
(

customer_ID char(5),
first_year int,
first_store char(5),
zip_code int,
DM char(2),
sex char(2),
birth_age char(20),
comment char(20)

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.customer
  OWNER TO postgres;
