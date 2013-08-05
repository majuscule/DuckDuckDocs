package DuckDuckDocs::Model::Docs;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

use Text::Markdown;
use IO::All;
use Data::Dumper;

use File::Find;
use vars qw/*name *dir *prune/;

*name   = *File::Find::name;
*dir    = *File::Find::dir;
*prune  = *File::Find::prune;

has docs => (
    is => 'ro',
    builder => '_generate',
);

#has source_dir => (
#    is => 'ro',
#    required => 1,
#);

my $source_dir = 'sources/DuckDuckGo-Documentation';

sub _generate {
    #my ( $self ) = @_;
    #warn $self->source_dir;
    my %duckduckdocs;
    find(sub {
        return if not -f "$_" or not /^[^.].+\.md$/;
        $dir =~ s:^$source_dir/?::;
        my @dirs = split '/', $dir;
        my $ref = \%duckduckdocs;
        warn $dir if $_ eq 'fathead-overview';
        warn Dumper \@dirs if $_ eq 'fathead-overview.md';
        for (@dirs) {
            $ref->{$_} = {} if (not exists $ref->{$_});
            $ref = $ref->{$_};
        }
        my $markdown = io($_)->slurp;
        my $html = Text::Markdown::markdown($markdown);
        s/\.md$//;
        $ref->{$_} = $html;
    }, $source_dir);
    #warn Dumper \%duckduckdocs;
    return \%duckduckdocs;
}

=head1 NAME

DuckDuckDocs::Model::Docs - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Dylan Lloyd <dylan@dylansserver.com>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
