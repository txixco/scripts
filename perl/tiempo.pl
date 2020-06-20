#!/usr/bin/perl

use FindBin;
use lib "$FindBin::Bin";

use strict;
use warnings;
#use diagnostics;

use IO::Prompt;
use Getopt::Long;

# Opciones
my ($tiempo, $repeticiones);

GetOptions( 'tiempo=s' => \$tiempo,
            'repeticiones=s' => \$repeticiones );

$tiempo && $repeticiones 
    || die "Debe especificar el tiempo y las repeticiones";

$| = 1;

print "Tiempo: $tiempo\nRepeticiones: $repeticiones\n\n";

# Al lío
my ($n, $cadena) = (0, '');

for (my $i = 1; $i <= $repeticiones; $i++) {
    for (my $j = 1; $j <= $tiempo; $j++) {
        $cadena = "Repetición $i-1: $j\r";
        printf("\r%s\r$cadena", " " x $n);
        $n = length($cadena);

        sleep 1;
    }

    for (my $j = 1; $j <= $tiempo; $j++) {
        $cadena = "Repetición $i-2: $j\r";
        printf("\r%s\r$cadena", " " x $n);
        $n = length($cadena);
        
        sleep 1;
    }
}
