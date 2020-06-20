#!/usr/bin/perl

use FindBin;
use lib "$FindBin::Bin";

use strict;
use warnings;
#use diagnostics;

use DBI;

use IO::Prompt;
use Getopt::Long;

use feature qw(switch say);

require "cambios-bda.pl";

# Opciones
my @inserta = ();
my @siguiente = ();
my @actualiza = ();
my ($borra, $muestra) = (0, '');

GetOptions( 'inserta=s{3}' => \@inserta,
            'siguiente=s{1,2}' => \@siguiente,
            'actualiza=s{3}' => \@actualiza,
            'borra=i' => \$borra,
            'muestra=s' => \$muestra);

# Al lío
die unless conecta();

if (@inserta) {
    insertaCambio(@inserta);
}

if (@siguiente) {
    siguiente(@siguiente);
}

if (@actualiza) {
    actualiza(@actualiza);
}

if ($borra) {
    borraCambio($borra);
}

if ($muestra) {
    my @filas = ();

    given ($muestra) {
        when (/^\d+$/) {
            @filas = tomaFila($muestra);
        }
        
        default {
            @filas = tomaCambio($muestra);
        }
    }
    
    foreach my $fila (@filas) {
        my ($id, $folio, $descripcion, $script, $proyecto, $estatus, 
            $fecha, $vobo, $comentarios) = notnuliza(@$fila);
        
        print "$id|$folio|$descripcion|$script|$proyecto|$estatus|$fecha"
        . "|$vobo|$comentarios\n";
    }
}
