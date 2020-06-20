#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use Text::CSV;
use Data::Random qw(:all);

# Variables
my @types = ( "Existing Business / Existing Company",
              "WS - New Partner",
              "New Business / Existing Company",
              "New Business / New Company");

my @stages = ( "Interest",
               "Discovery",
               "Solution",
               "Negotiation",
               "Contract",
               "Closed Won",
               "Closed Won",
               "Closed Won",
               "Closed Won",
               "Closed Lost" );

my @ownership = ( "0012D000002kYDJQA2|0052D000000VrtRQAS",
                  "0012D000002kYGrQAM|0052D000000VrmuQAC" );

my @appTypes = ( "Product Launch",
                 "Benefit Fair/Rollout",
                 "Corporate Communications",
                 "Lead Generation",
                 "Other" );

my @yesNo = ( "Yes",
              "No" );

# CSV initialization
my $csv = Text::CSV->new({binary => 1, eol => $/ })
    or die "Failed to create a CSV handle: $!";
my $filename = "opportunities.csv";

open my $fh, ">", $filename or die "failed to create $filename: $!";

my(@heading) = ( "ACCOUNTID",
                 "OWNERID",
                 "RECORDTYPEID",
                 "NAME",
                 "STAGENAME",
                 "CLOSEDATE",
                 "TYPE",
                 "AMOUNT",
                 "LEADSOURCE",
                 "LEAD_SOURCE_DETAIL__C",
                 "CURRENCYISOCODE",
                 "APPLICATION_TYPE__C",
                 "OPPORTUNITY_FROM_INTELLICONNECTION__C" );

$csv->print($fh, \@heading);

# Let's go
my @dataRow;

for (my $i=0; $i<1000; $i++) {
    @dataRow = ( split(/\|/, rand_enum(set => \@ownership)),
                 '012600000005L68AAE',
                 ucfirst(rand_chars(set => 'loweralpha',
                                    size => 10)),
                 rand_enum(set => \@stages),
                 rand_date(min => '2017-01-01', max => '2018-12-31'),
                 rand_enum(set => \@types),
                 scalar rand_chars(set => 'numeric',
                                   min => 5,
                                   max => 6),
                 'Social Media',
                 'LinkedIn Standard',
                 'USD',
                 rand_enum(set => \@appTypes),
                 rand_enum(set => \@yesNo) );

    $csv->print($fh, \@dataRow);
}

close $fh or die "failed to close $filename: $!";
