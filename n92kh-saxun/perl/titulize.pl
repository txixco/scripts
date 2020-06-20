#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use File::Basename;

for (@ARGV) {
	my ($name, undef, $ext) = fileparse($_, qr/\.[^.]*/);
   my $old = $name;

	# Change spaces, dots and dashes to _
	my $new = $name;
 	$new =~ s/[\s\-\.]+/_/g;
 
	# Un-capitalize
	$new =~ s/(\w)/\L$1/g;
	$new =~ s/(^)(\w)/$1\U$2/g;
	myRename("$name$ext", "$new$ext");

	# Print result
 	print "$old$ext -> $new$ext\n";
}

sub myRename {
	my ($fileNameOld, $fileNameNew) = @_;
 	rename($fileNameOld, $fileNameNew) or die "No se pudo renombrar '$fileNameOld' a '$fileNameNew': $!";
}
