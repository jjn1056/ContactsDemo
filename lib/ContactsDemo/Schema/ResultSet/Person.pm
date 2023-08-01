package ContactsDemo::Schema::ResultSet::Person;

use base 'ContactsDemo::Schema::ResultSet';
use ContactsDemo::Syntax;

sub find_by_id($self, $id) {
  return $self->find({id=>$id});
}

sub find_active_user($self, $id) {
  return $self->find({id=>$id});
}
sub unauthenticated_user($self, $args=+{}) {
  return $self->new_result($args);  
}

1;
