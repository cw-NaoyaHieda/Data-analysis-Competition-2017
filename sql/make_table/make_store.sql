-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.store;

CREATE TABLE public.store
(

store_id char(2),
store_name char(10),
latitude numeric,
longitude numeric,
floor char(4)

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.customer
  OWNER TO postgres;