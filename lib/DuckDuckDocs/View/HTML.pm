package DuckDuckDocs::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::Xslate';

__PACKAGE__->config(
    template_extension => '.tx',
    path => [ 'root/templates', ],
    header => [ 'header.tx', ],
    footer => [ 'footer.tx', ],
);

1;

=head1 NAME

DuckDuckDocs::View::HTML - Xslate View for DuckDuckDocs

=head1 DESCRIPTION

Xslate View for DuckDuckDocs.

=cut

