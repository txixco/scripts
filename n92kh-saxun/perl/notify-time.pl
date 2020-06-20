#!/usr/bin/perl

use strict;
use warnings;

my $format = shift @ARGV;
my $time=`date $format`;

system "notify-send \"$time\" \" \" -i appointment-new &";
