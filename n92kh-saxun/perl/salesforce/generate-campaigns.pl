#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use Text::CSV;
use Text::Lorem;
use Data::Random qw(:all);

# Variables
my @statuses = ( "In Progress",
                 "Completed",
                 "Aborted" );

my @owners = ( "0052D000000VrmuQAC",
               "0052D000000VrtRQAS" );

my @booleans = ( "true",
                 "true",
                 "true",
                 "false" );

# CSV initialization
my $csv = Text::CSV->new({binary => 1, eol => $/ })
    or die "Failed to create a CSV handle: $!";
my $filename = "campaigns.csv";

open my $fh, ">", $filename or die "failed to create $filename: $!";

my(@heading) = ( "NAME",
                 "STATUS",
                 "STARTDATE",
                 "ENDDATE",
                 "CURRENCYISOCODE",
                 "EXPECTEDREVENUE",
                 "BUDGETEDCOST",
                 "ACTUALCOST",
                 "ISACTIVE",
                 "DESCRIPTION",
                 "OWNERID",
                 "REGION__C" );

$csv->print($fh, \@heading);

# Let's go
my @dataRow;
my ($startDate, $endDate);
my ($budgetedCost, $actualCost, $expectedRevenue);
my $perc;

for (my $i=0; $i<500; $i++) {
    $startDate = rand_date(min => '2017-01-01', max => '2018-11-30');
    $endDate = rand_date(min => $startDate, max => '2018-12-31'),;

    $budgetedCost = scalar rand_chars(set => 'numeric',
                                      min => 5,
                                      max => 6);
    $perc = scalar rand_chars(set => 'numeric',
                              size => 2);
    $perc = $budgetedCost * $perc / 100;
    $perc = ($perc lt 30) ? $perc * -1 : $perc;
    $actualCost = $budgetedCost + $perc;
    $perc = scalar rand_chars(set => 'numeric',
                              size => 2);
    $perc = $budgetedCost * ($perc + 100) / 100;
    $expectedRevenue = $budgetedCost + $perc;

    @dataRow = ( ucfirst(rand_chars(set => 'loweralpha',
                                    size => 10)),
                 rand_enum(set => \@statuses),
                 $startDate,
                 $endDate,
                 'USD',
                 $expectedRevenue,
                 $budgetedCost,
                 $actualCost,
                 rand_enum(set => \@booleans),
                 loremString(10),
                 rand_enum(set => \@owners),
                 'LA' );

    $csv->print($fh, \@dataRow);
}

close $fh or die "failed to close $filename: $!";

# Subprogramas
sub loremString {
    my $size = shift;
    my $text = Text::Lorem->new();

    return $text->words($size);
}
