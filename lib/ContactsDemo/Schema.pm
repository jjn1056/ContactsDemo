package ContactsDemo::Schema;

use base 'DBIx::Class::Schema';
use ContactsDemo::Syntax;

our $VERSION = 1;

__PACKAGE__->load_components(qw/
  Helper::Schema::QuoteNames
  Helper::Schema::DidYouMean
  Helper::Schema::DateTime/);

__PACKAGE__->load_namespaces(
  default_resultset_class => "DefaultRS");

1;
