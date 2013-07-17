use strict;
use warnings;

use DuckDuckDocs;

my $app = DuckDuckDocs->apply_default_middlewares(DuckDuckDocs->psgi_app);
$app;

