#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use Text::CSV;
use Text::Lorem;
use Data::Random qw(:all);

# Variables
my @salutations = ( "Dr.", "Mr.", "Mrs.", "Ms." );

my @companies = ( "Smith's Global Co.",
                  "Jones Medical Corp" );

my @status = ( "Open",
               "Attempting to Contact",
               "Qualifying Opportunity",
               "Convert to Contact",
               "Inactive",
               "Rep Abandoned",
               "Unqualified" );

my @owners = ( "0052D000000VrmuQAC",
               "0052D000000VrtRQAS" );

# CSV initialization
my $csv = Text::CSV->new({binary => 1, eol => $/ })
    or die "Failed to create a CSV handle: $!";
my $filename = "leads.csv";

open my $fh, ">", $filename or die "failed to create $filename: $!";

my(@heading) = (  "LASTNAME",
                  "FIRSTNAME",
                  "SALUTATION",
                  "RECORDTYPEID",
                  "COMPANY",
                  "PHONE",
                  "DESCRIPTION",
                  "LEADSOURCE",
                  "LEADSOURCEDETAILC2ACCT__C",
                  "LEADSOURCEDETAILC2OPP__C",
                  "STATUS",
                  "CURRENCYISOCODE",
                  "OWNERID" );

$csv->print($fh, \@heading);

# Let's go
my @dataRow;
for (my $i=0; $i<1000; $i++) {
    @dataRow = ( ucfirst(rand_chars(set => 'loweralpha',
                                   size => 10)),
                 ucfirst(rand_chars(set => 'loweralpha',
                                   size => 10)),
                 rand_enum(set => \@salutations),
                 "012600000005L4RAAU",
                 rand_enum(set => \@companies),
                 scalar rand_chars(set => 'numeric',
                                   size => 10),
                 loremString(10),
                 "Social Media",
                 "LinkedIn Standard",
                 "LinkedIn Standard",
                 rand_enum(set => \@status),
                 "USD",
                 rand_enum(set => \@owners) );

    $csv->print($fh, \@dataRow);
}

close $fh or die "failed to close $filename: $!";

# Subprogramas
sub loremString {
    my $size = shift;
    my $text = Text::Lorem->new();

    return $text->words($size);
}
