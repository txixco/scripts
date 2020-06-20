#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use File::Basename;
use File::Find;

# Variables
my ($old, $new, $ext) = ('', '', '');

# Go!
for (@ARGV) {
    if (-d) {
        $old = $_;
        $new = join('', map(ucfirst, split(' ', $old)));

        print "$old -> $new\n";
        rename($old, $new) or die "No se pudo renombrar '$old' a '$new': $!";

        find(sub { renameFile($_, $new) }, $new);

        print "\n";
    }
}

# Subprogramas

sub renameFile {
    my ($oldFileName, $newFileName) = @_;

    if ($oldFileName =~ /.*\.(csproj|st)$/) {
        rename("$oldFileName", "$newFileName.$1") 
                or die "No se pudo renombrar '$oldFileName' a '$newFileName': $!"
    }
}

### Local Variables:
### coding: utf-8-unix
### End:
