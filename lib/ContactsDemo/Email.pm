package ContactsDemo::Email;

use Moo;
use ContactsDemo::Syntax;
use Email::Stuffer;
use Data::Section::Simple 'get_data_section';
use Template::Tiny;

has mailer => (is=>'ro', required=>1);
has template => (is=>'ro', default=>sub { Template::Tiny->new });

around BUILDARGS => sub($orig, $class, @args) {                                                                                      
  my $args = $class->$orig(@args);
  $args->{mailer} = $class->build_mailer($args);
  return $args;
};

sub build_mailer($class, $args) {
  my $transport = $args->{transport} // die "Missing transport";
  my $transport_args = $args->{transport_args} // die "Missing transport_args";
  my $mailer = Email::Stuffer->transport($transport, $transport_args) // die "Failed to create Email::Stuffer";
}

sub fill($self, $template_name, $vars) {
  my $output;
  my $template = get_data_section($template_name);
  $self->template->process(\$template, $vars, \$output) || die $self->template->error;
  return $output;
}

sub welcome($self, $to) {
  return $self->mailer
    ->to($to)
    ->from('us@contacts_demo.com')
    ->subject('Welcome to Contacts Demo')
    ->html_body($self->fill('welcome.html', +{ name => $to }))
    ->send;
}

1;

__DATA__
 
@@ welcome.html
<html>
 <body>
  <p>Welcome to Contacts Demo [% name %]!</p>
  <p>This is a demo of a web application built with <b>Catalyst</b>.</p>
 </body>
</html>