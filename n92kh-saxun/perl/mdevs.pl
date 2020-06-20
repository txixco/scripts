#!/usr/bin/perl

use strict;

my @mounted = `mount`;

print "[begin] (Desmontar)\n";
for (@mounted) {
	if (m/ (\/media\/[^ ]+) /) {
		print "\t[exec] ($1) {eject $1}\n";
	}
}
print "[end]\n";
