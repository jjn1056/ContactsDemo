package ContactsDemo::Schema::ResultSet::Person;

use ContactsDemo::Syntax;
use base 'ContactsDemo::Schema::ResultSet';

sub find_by_id($self, $id) {
  return $self->find({id=>$id});
}

sub unauthenticated_user($self, $args=+{}) {
  return $self->new_result($args);  
}

1;
