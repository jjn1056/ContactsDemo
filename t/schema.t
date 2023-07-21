use strict;
use warnings;

use Test::Most;
use Test::DBIx::Class
  -schema_class => 'ContactsDemo::Schema',
  qw(Person Contact);


ok my $person = Person->create({
  first_name => 'John',
  last_name => 'Smith',
  username => 'jsmith',
  password => 'abc123',
  password_confirmation => 'abc123',
}), 'create person';


ok $person->valid, 'person is valid';
ok defined($person->id), 'has id';
ok $person->password, 'has password';
is $person->first_name, 'John', 'first name is correct';
is $person->last_name, 'Smith', 'last name is correct';
is $person->check_password('abc123'), 1, 'password is correct';

done_testing;