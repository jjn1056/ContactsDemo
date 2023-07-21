package ContactsDemo::PSGI;

use Plack::Runner;
use ContactsDemo;
use ContactsDemo::Syntax;

sub run { Plack::Runner->run(@_, ContactsDemo->to_app) }

return caller(1) ? 1 : run(@ARGV);
