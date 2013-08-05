package DuckDuckDocs::Controller::Root;
use Moose;
use namespace::autoclean;
use DuckDuckDocs::Model::Docs;

BEGIN { extends 'Catalyst::Controller' }

#has docs => (
#    is => 'ro',
#    default => sub {
#        DuckDuckDocs::Model::Docs->new(
#            source_dir => 'sources/DuckDuckGo-Documentation'
#        )
#    },
#);

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

DuckDuckDocs::Controller::Root - Root Controller for DuckDuckDocs

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $docs = $c->model('Docs')->docs;
    $c->stash(template => 'index.tx', docs => $docs);
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Dylan Lloyd <dylan@dylansserver.com>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
