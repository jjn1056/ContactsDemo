-- Verify contactsdemo:initial on sqlite

BEGIN;

select 1 from person limit 1;
select 1 from contact limit 1;
select 1 from contact_phone limit 1;
select 1 from contact_email limit 1;

ROLLBACK;
