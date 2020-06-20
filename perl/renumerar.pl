#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use Getopt::Long;
use Cwd;
use File::Basename;

my ($string, $ext, $digit);

GetOptions( 'string=s' => \$string,
			'ext=s' => \$ext,
			'digit=i' => \$digit );

$string = $string || fileparse(getcwd());
$digit = $digit || 2;

if (not $ext) {
	print "Se debe especificar la extensión\n";
	exit;
}

opendir THISDIR, "." or die "no se puede abrir el directorio: $!";
my @files = sort grep /.+.$ext/io, readdir THISDIR;
closedir THISDIR;

my ($cents, $num, $i, $file, $newfile) = (10 ** $digit, 0, 1, '', '');

foreach $file (@files)
{
	$num = $cents + $i;
	$num = substr $num, 1, $digit;
	$newfile = "$string-$num.$ext";
	print "Renaming $file to $newfile...\n";
	rename $file, $newfile or die "no se puede renombrar $file: $!";
	$i++;
}
