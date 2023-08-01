requires 'Module::Runtime';
requires 'Import::Into';
requires 'experimental', '0.020';
requires 'Moose';
requires 'Scalar::Util';
requires 'String::CamelCase';
requires 'HTTP::Headers::ActionPack';
requires 'Server::Starter';
requires 'Gazelle';

requires 'DBD::Pg';
requires 'App::Sqitch';
requires 'Plack';
requires 'Type::Tiny';
requires 'Hash::Merge';
requires 'Email::Stuffer';
requires 'Data::Section::Simple';
requires 'Template::Tiny';

requires 'Valiant';

requires 'Catalyst::Runtime', '5.90131';
requires 'Catalyst::Plugin::RedirectTo', '0.004';
requires 'Catalyst::Plugin::URI', '0.005';
requires 'CatalystX::Errors', '0.001009';
requires 'Catalyst::Plugin::ServeFile', '0.004';
requires 'Catalyst::Plugin::CSRFToken', '0.006';
requires 'Catalyst::Plugin::Session';

requires 'Catalyst::Plugin::Session::Store::Cookie';
requires 'Catalyst::Plugin::Session::State::Cookie';

requires 'Catalyst::Model::DBIC::Schema', '0.65';
requires 'Catalyst::Component::InstancePerContext';
requires 'Catalyst::ControllerRole::At';
requires 'Catalyst::ControllerPerContext';
requires 'CatalystX::Errors', '0.001009';
requires 'CatalystX::RequestModel', '0.018';
requires 'Catalyst::ActionRole::RenderView', '0.002';

requires 'DBIx::Class', '0.082840';
requires 'DBIx::Class::Helpers', '2.033003';
requires 'DBIx::Class::TimeStamp', '0.14';
requires 'DBIx::Class::BcryptColumn', '0.001003';
requires 'DBIx::Class::ResultClass::TrackColumns', '0.001002';

on test => sub {
  requires 'Test::Most' => '0.34';
  requires 'Test::Lib', '0.002';
  requires 'Test::Needs', '0.002006';
  requires 'Test::DBIx::Class'=> '0.52';
};
