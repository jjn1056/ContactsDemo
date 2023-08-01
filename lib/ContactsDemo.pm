package ContactsDemo;

use Catalyst;
use Moose;
use ContactsDemo::Syntax;
use Valiant::I18N; # Needed to load $HOME/locale

__PACKAGE__->setup_plugins([qw/
  Session
  Session::State::Cookie
  Session::Store::Cookie
  RedirectTo
  URI
  Errors
  ServeFile
  CSRFToken
/]);

__PACKAGE__->config(
  disable_component_resolution_regex_fallback => 1,
  using_frontend_proxy => 1,
  'Plugin::Session' => { storage_secret_key => $ENV{SESSION_STORAGE_SECRET} },
  'Plugin::CSRFToken' => { auto_check =>1, default_secret => $ENV{CSRF_SECRET} },
  'Model::Email' => {
    transport => 'SMTP',
    transport_args => {
      host => $ENV{SMTP_HOST},
      port => $ENV{SMTP_PORT},
    },
  },
  'Model::Schema' => {
    traits => ['SchemaProxy'],
    schema_class => 'ContactsDemo::Schema',
    connect_info => {
      dsn => "dbi:Pg:dbname=@{[ $ENV{POSTGRES_DB} ]};host=@{[ $ENV{DB_HOST} ]};port=@{[ $ENV{DB_PORT} ]}",
      user => $ENV{POSTGRES_USER},
      password => $ENV{POSTGRES_PASSWORD},
    },
  },
);

__PACKAGE__->setup();
  
has user => (
  is => 'rw',
  lazy => 1,
  required => 1,
  builder => '_get_user',
  clearer => 'clear_user',
);

sub _get_user($self) {
  my $id = $self->model('Session')->user_id // return $self->model('Schema::Person')->unauthenticated_user;
  my $person = $self->model('Schema::Person')->find_active_user($id) // $self->logout && die "Bad ID '$id' in session";
  return $person;
}

sub persist_user_to_session($self, $user) {
  $self->model('Session')->user_id($user->id);
}

sub authenticate($self, $user, @args) {
  $self->persist_user_to_session($user) if my $authenticated = $user->authenticate(@args);
  return $authenticated;
}

sub logout($self) {
  $self->model('Session')->logout;
  $self->clear_user;
}

__PACKAGE__->meta->make_immutable();
