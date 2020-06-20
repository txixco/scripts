#!/usr/bin/perl

use strict;

my $program = shift;

while () {
	system("$program");
	sleep(1);
}
