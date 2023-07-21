package ContactsDemo::ActionRole::Authenticated;

use Moose::Role;
use ContactsDemo::Syntax;

requires 'match', 'match_captures';

around ['match','match_captures'] => sub($orig, $self, $ctx, @args) {
  return $self->$orig($ctx, @args) if $ctx->can('user') && $ctx->user->authenticated;
  return 0;
};

1;
