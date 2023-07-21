package ContactsDemo::Schema::ResultSet::Contact;

use ContactsDemo::Syntax;
use base 'ContactsDemo::Schema::ResultSet';

sub new_contact($self, $attrs={}) {
  return my $contact = $self->new_result($attrs);
}
1;
