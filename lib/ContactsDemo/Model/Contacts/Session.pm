package ContactsDemo::Model::Contacts::Session;

use Moo;
use Hash::Merge 'merge';
use ContactsDemo::Syntax;

extends 'Catalyst::Model';
with 'Catalyst::Component::InstancePerContext';

has page => (is=>'ro', required=>1, default=>1); 

sub build_per_context_instance($self, $c, $q) {
  my $args = merge( $q->nested_params, ($c->model('Session')->contacts_query //+{}) );
  $c->model('Session')->contacts_query($args);
  return ref($self)->new(%$args);
}

1;
