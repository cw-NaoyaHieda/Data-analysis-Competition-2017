-- View: public.staff_monthly

-- DROP VIEW public.staff_monthly;

CREATE OR REPLACE VIEW public.staff_monthly AS 
 SELECT receipt_henpin_syori.regi_staff,
    date_trunc('month'::text, receipt_henpin_syori.dt::timestamp with time zone) AS date_trunc,
    count(*) AS all_count,
    count(simei = '指名') AS only_simei_count
   FROM receipt_henpin_syori
  GROUP BY receipt_henpin_syori.regi_staff, (date_trunc('month'::text, receipt_henpin_syori.dt::timestamp with time zone))
  ORDER BY receipt_henpin_syori.regi_staff, (date_trunc('month'::text, receipt_henpin_syori.dt::timestamp with time zone));

ALTER TABLE public.staff_monthly
  OWNER TO postgres;
