package ContactsDemo::FormBuilder;

use Moo;
use ContactsDemo::Syntax;

extends 'Valiant::HTML::FormBuilder';

sub successfully_updated($self) {
  return $self->model->validated && !$self->model->has_errors;
}

1;
