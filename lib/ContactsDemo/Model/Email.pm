package ContactsDemo::Model::Email;

use Moo;
use ContactsDemo::Syntax;
use ContactsDemo::Email;

extends 'Catalyst::Model';

sub COMPONENT {
  my ($class, $app, $args) = @_;
  my $merged_args = $class->merge_config_hashes($class->config, $args);
  return ContactsDemo::Email->new($merged_args);
}

1;