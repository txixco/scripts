#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use IO::Prompt;
use Getopt::Long;

use Text::Template;
use DateTime;

# Variables
my ($help, $archivo, $texto, $plantilla) = ('', '', '', '');

GetOptions( 'help' => \$help );

if ($help) {
    print "Uso: ./libera.pl archivo\n";
    exit;
}

# Archivo a usar de plantilla
$archivo = shift @ARGV 
    or die "Se debe especificar la plantilla\n";

# Inicializa la plantilla
$plantilla = Text::Template->new(SOURCE => "$archivo")
	or die "No se puede abrir la plantilla: $Text::Template::ERROR";

# Genera la salida
my $hoy = DateTime->now(time_zone=>'local');
my $fecha = $hoy->dmy('/') . ' ' . $hoy->hms;

my %vars = ( fecha => $fecha,
             archivo => \&archivo );

$texto = $plantilla->fill_in( OUTPUT => \*STDOUT,
                              HASH => \%vars )
    or die "No se puede rellenar la plantilla: $Text::Template::ERROR";

# Subprogramas
sub archivo {
    my $archivo = shift @_;
    my @retorno = '';

    open ARCHIVO, "<", lc($archivo) 
        or die "No se puede abrir el archivo " . lc($archivo) . ": $!";

    @retorno = <ARCHIVO>;
    close ARCHIVO;

    push(@retorno, '/');

    return join('', @retorno);
}

sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
