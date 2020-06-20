#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use Text::CSV;
use Text::Lorem;
use Data::Random qw(:all);

# Variables
my @owners = ( "0052D000000VrtRQAS",
               "0052D000000VrmuQAC" );

my @leads = ( "00Q2D0000018nILUAY", 
              "00Q2D0000018nIMUAY", 
              "00Q2D0000018nINUAY", 
              "00Q2D0000018nIOUAY", 
              "00Q2D0000018nIPUAY", 
              "00Q2D0000018nIQUAY", 
              "00Q2D0000018nIRUAY", 
              "00Q2D0000018nISUAY", 
              "00Q2D0000018nITUAY", 
              "00Q2D0000018nIUUAY", 
              "00Q2D0000018nIVUAY", 
              "00Q2D0000018nIWUAY", 
              "00Q2D0000018nIXUAY", 
              "00Q2D0000018nIYUAY", 
              "00Q2D0000018nIZUAY", 
              "00Q2D0000018nIaUAI", 
              "00Q2D0000018nIbUAI", 
              "00Q2D0000018nIcUAI", 
              "00Q2D0000018nIdUAI", 
              "00Q2D0000018nIeUAI", 
              "00Q2D0000018nIfUAI", 
              "00Q2D0000018nIgUAI", 
              "00Q2D0000018nIhUAI", 
              "00Q2D0000018nIiUAI", 
              "00Q2D0000018nIjUAI", 
              "00Q2D0000018nIkUAI", 
              "00Q2D0000018nIlUAI", 
              "00Q2D0000018nImUAI", 
              "00Q2D0000018nInUAI", 
              "00Q2D0000018nIoUAI", 
              "00Q2D0000018nIpUAI", 
              "00Q2D0000018nIqUAI", 
              "00Q2D0000018nIrUAI", 
              "00Q2D0000018nIsUAI", 
              "00Q2D0000018nItUAI", 
              "00Q2D0000018nIuUAI", 
              "00Q2D0000018nIvUAI", 
              "00Q2D0000018nIwUAI", 
              "00Q2D0000018nIxUAI", 
              "00Q2D0000018nIyUAI", 
              "00Q2D0000018nIzUAI", 
              "00Q2D0000018nJ0UAI", 
              "00Q2D0000018nJ1UAI", 
              "00Q2D0000018nJ2UAI", 
              "00Q2D0000018nJ3UAI", 
              "00Q2D0000018nJ4UAI", 
              "00Q2D0000018nJ5UAI", 
              "00Q2D0000018nJ6UAI", 
              "00Q2D0000018nJ7UAI", 
              "00Q2D0000018nJ8UAI", 
              "00Q2D0000018nJ9UAI" );

# CSV initialization
my $csv = Text::CSV->new({binary => 1, eol => $/ })
    or die "Failed to create a CSV handle: $!";
my $filename = "payouts.csv";

open my $fh, ">", $filename or die "failed to create $filename: $!";

my(@heading) = ( "OWNERID",
                 "NAME",
                 "CURRENCYISOCODE",
                 "AMOUNT__C",
                 "PAY_DATE__C",
                 "DEAL__C" );

$csv->print($fh, \@heading);

# Let's go
my @dataRow;

for (my $i=0; $i<100; $i++) {
    @dataRow = ( rand_enum(set => \@owners),
                 ucfirst(rand_chars(set => 'loweralpha',
                                    size => 10)),
                 'USD',
                 scalar rand_chars(set => 'numeric',
                                   min => 5,
                                   max => 6),
                 rand_date(min => '2017-01-01', max => '2018-12-31'),
                 rand_enum(set => \@leads) );

    $csv->print($fh, \@dataRow);
}

close $fh or die "failed to close $filename: $!";
