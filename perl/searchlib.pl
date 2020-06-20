#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

# Opciones
my ($package, $lib) = ('', $ARGV[0]);

$package = (split /\n/, `sudo apt-file search $lib`)[0];
$package = (defined $package ? (split /:/, $package)[0] : "No encontrado");

saca("$lib => $package");

# Subs
sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
