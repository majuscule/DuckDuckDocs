package DuckDuckDocs::View::HTML;

use strict;
use warnings;
use Data::Dumper;
use HTML::Tiny;

use base 'Catalyst::View::Xslate';

my $html = HTML::Tiny->new(mode => 'html');

sub build_menu {
    my %menu;
    sub recurse {
        my ( $docs, $menu ) = @_;
        for (keys %{$docs}) {
            if (ref $docs->{$_} eq 'HASH') {
                $menu->{$_} = {};
                recurse($docs->{$_}, $menu->{$_});
            } else {
                $menu->{$_} = $docs->{$_};
            }
        }
    };
    recurse shift, \%menu;
    $html->ul({ id => 'menu' }, [map {
        $html->li($html->a({ href => "#$_" }, $_))
    } grep {
        1#ref $menu{$_} eq 'HASH'
    } keys %menu]);
}

__PACKAGE__->config(
    template_extension => '.tx',
    path => [ 'root/templates', ],
    header => [ 'header.tx', ],
    footer => [ 'footer.tx', ],
    function => {
        build_menu => \&build_menu,
        build_docs => \&build_docs,
    },
);

1;

=head1 NAME

DuckDuckDocs::View::HTML - Xslate View for DuckDuckDocs

=head1 DESCRIPTION

Xslate View for DuckDuckDocs.

=cut

