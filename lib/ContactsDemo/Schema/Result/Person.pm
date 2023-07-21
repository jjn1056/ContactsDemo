package ContactsDemo::Schema::Result::Person;

use base 'ContactsDemo::Schema::Result';
use ContactsDemo::Syntax;

__PACKAGE__->table("person");

__PACKAGE__->add_columns(
  id => { data_type => 'bigint', is_nullable => 0, is_auto_increment => 1 },
  username => { data_type => 'varchar', is_nullable => 0, size => 48 },
  first_name => { data_type => 'varchar', is_nullable => 0, size => 24 },
  last_name => { data_type => 'varchar', is_nullable => 0, size => 48 },
  password => {
    data_type => 'varchar',
    is_nullable => 0,
    size => 64,
    bcrypt => 1,
  },
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(['username']);

__PACKAGE__->has_many(
  contacts => '::Contact',
  { 'foreign.person_id' => 'self.id' }
);

__PACKAGE__->validates(first_name => (presence=>1, length=>[2,24]));
__PACKAGE__->validates(last_name => (presence=>1, length=>[2,48]));
__PACKAGE__->validates(username => presence=>1, length=>[3,24], format=>'alpha_numeric', unique=>1);
__PACKAGE__->validates( password => (presence=>1, confirmation => 1,  on=>'create' ));
__PACKAGE__->validates( password => (confirmation => { 
    on => 'update',
    if => 'is_column_changed', # This method defined by DBIx::Class::Row
  }));

__PACKAGE__->accept_nested_for('contacts', {allow_destroy=>1});

sub authenticated($self) {
  return $self->username && $self->in_storage ? 1:0;
}

sub authenticate($self, $request) {
  my ($username, $password) = $request->get('username', 'password');
  my $found = $self->result_source->resultset->find({username=>$username});

  if($found && $found->in_storage && $found->check_password($password)) {
    %$self = %$found;
    return $self;
  } else {
    $self->errors->add(undef, 'Invalid login credentials');
    $self->username($username) if defined($username);
    return 0;
  }
}

sub registered($self) {
  return $self->username &&
    $self->first_name &&
    $self->last_name &&
    $self->password &&
    $self->in_storage ? 1:0;
}

sub register($self, $request) {
  return $self->set_from_request($request);
}

1;
