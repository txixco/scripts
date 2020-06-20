#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use File::Basename;

for (@ARGV) {
	my ($name, undef, $ext) = fileparse($_, qr/\.[^.]*/);
 
 	# Uncapitalize
	my $new = $name;
 	$new =~ s/(\w+)/\L$1/g;
 	myRename("$name$ext", "$new$ext");

	# Print result
 	print "$name$ext -> $new$ext\n";
}

sub myRename {
	my ($fileNameOld, $fileNameNew) = @_;
 	rename($fileNameOld, $fileNameNew) 
	    or die "No se pudo renombrar '$fileNameOld' a 'fileNameNew': $!";
}
