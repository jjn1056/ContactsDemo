package ContactsDemo::Model::Schema;

use Moose;
use ContactsDemo::Syntax;

extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->meta->make_immutable();