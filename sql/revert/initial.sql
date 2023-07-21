-- Revert contactsdemo:initial from sqlite

BEGIN;

DROP TABLE contact_phone;

DROP TABLE contact_email;

DROP TABLE contact;

DROP TABLE person;

DROP TABLE role;

DROP TABLE state;


COMMIT;
