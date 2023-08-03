package ContactsDemo::Schema::Result::Contact::Email;

use base 'ContactsDemo::Schema::Result';
use ContactsDemo::Syntax;

__PACKAGE__->table("contact_email");
__PACKAGE__->load_components(qw/Valiant::Result/);

__PACKAGE__->add_columns(
  id => { data_type => 'integer', is_nullable => 0, is_auto_increment => 1 },
  contact_id => { data_type => 'integer', is_nullable => 0, is_foreign_key => 1 },
  address => { data_type => 'varchar', is_nullable => 0, size => '96' },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to(
  contact => '::Contact',
  { 'foreign.id' => 'self.contact_id' }
);

__PACKAGE__->validates(address => ( presence => 1, format => 'email'));

1;
