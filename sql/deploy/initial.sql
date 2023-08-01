-- Deploy contactsdemo:initial to sqlite

BEGIN;

CREATE TABLE person (
  id BIGSERIAL PRIMARY KEY,
  username varchar(48) NOT NULL,
  first_name varchar(24) NOT NULL,
  last_name varchar(48) NOT NULL,
  password varchar(64) NOT NULL
);

CREATE UNIQUE INDEX person_username ON person (username);

CREATE TABLE contact (
  id BIGSERIAL PRIMARY KEY,
  person_id integer NOT NULL,
  first_name varchar(24) NOT NULL,
  last_name varchar(48) NOT NULL,
  notes text,
  FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE contact_email (
  id BIGSERIAL PRIMARY KEY,
  contact_id integer NOT NULL,
  address varchar(96) NOT NULL,
  FOREIGN KEY (contact_id) REFERENCES contact(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE contact_phone (
  id BIGSERIAL PRIMARY KEY,
  contact_id integer NOT NULL,
  phone_number varchar(96) NOT NULL,
  FOREIGN KEY (contact_id) REFERENCES contact(id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMIT;
