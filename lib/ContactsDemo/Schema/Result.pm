package ContactsDemo::Schema::Result;

use base 'DBIx::Class';
use ContactsDemo::Syntax;

__PACKAGE__->load_components(qw/
  Valiant::Result
  BcryptColumn
  ResultClass::TrackColumns
  Helper::Row::RelationshipDWIM
  Core
  InflateColumn::DateTime
  /);
 
sub default_result_namespace { 'ContactsDemo::Schema::Result' }

sub set_from_request($self, $request) {
  $self->set_columns_recursively($request->nested_params)
      ->insert_or_update;
  return $self->valid;
}

1;
