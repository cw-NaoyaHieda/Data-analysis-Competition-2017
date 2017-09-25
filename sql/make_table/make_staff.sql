-- Table: public.customer

-- DROP TABLE public.customer;
DROP TABLE IF EXISTS  public.staff;

CREATE TABLE public.staff
(

staff_id char(3),
store_id char(10)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.staff
  OWNER TO postgres;