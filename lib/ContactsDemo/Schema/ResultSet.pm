package ContactsDemo::Schema::ResultSet;

use base 'DBIx::Class::ResultSet';
use ContactsDemo::Syntax;

__PACKAGE__->load_components(qw/
  Valiant::ResultSet
  Helper::ResultSet::Shortcut
  Helper::ResultSet::Me
  Helper::ResultSet::SetOperations
  Helper::ResultSet::IgnoreWantarray
/);

# get the given page of the resultset, or last page if the requested one exceeds
# the total number of available pages.
sub page_or_last($self, $page) {
  my $paged_resultset = $self->page($page);
  my $last_page = $paged_resultset->pager->last_page;

  $paged_resultset = $paged_resultset->page($last_page)
    if $page > $last_page;

  return $paged_resultset;
}

# filter a resultset by standard query model filters such as page, etc.
sub filter_by_request($self, $request) {
  my $filtered_resultset = $self;
  if($request->can('page')) {
    $filtered_resultset = $filtered_resultset->page_or_last($request->page // 1);
  }
  return $filtered_resultset;
}

# alias for new_result with slighting improved syntax
sub build($self, $attrs={}) {
  my $new = $self->new_result($attrs);
  return $new;
} 

# create a new record from a $request object which does the CatalystX::QueryModel::DoesQueryModel
# or https://metacpan.org/pod/CatalystX::RequestModel::DoesRequestModel role.
sub create_from_request($self, $request) {
  return my $new = $self->create($request->nested_params);
}

# return an array of hashes as results.  Usually used in debugging.
sub _to_array($self) {
  return $self->search(
    {},
    {result_class => 'DBIx::Class::ResultClass::HashRefInflator'}
  )->all;
}


1;
