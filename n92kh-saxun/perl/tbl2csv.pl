#!/usr/bin/perl

use FindBin;
use lib "$FindBin::Bin";

use strict;
use warnings;
#use diagnostics;

use DBI;

use IO::Prompt;
use Getopt::Long;

require "dbutils.pl";

# Opciones
my ($tabla, $funcion, $ruta, @partes);

GetOptions( 'tabla=s' => \$tabla,
			'funcion=s' => \$funcion,
			'ruta=s' => \$ruta,
			'partes=s' => \@partes );

# Realizamos la conexión
my $dbh = conecta() or die;
$dbh->do("ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY'");

# Proceso
$tabla = uc($tabla);
$ruta =~ s/\/$//;

if (not @partes) {
	@partes = tomaPartes($tabla, $funcion);
}

my $cabecero = join("|", tomaColumnas($tabla));

foreach ( @partes ) {
	my $sth = exporta($tabla, $funcion, $_, $cabecero);
}

# Fin de la conexión
END {
	$dbh->disconnect if defined($dbh);
}

# Subs
sub saca {
	print $_[0] . "\n";
}

sub tomaPartes {
	my ($tabla, $funcion) = @_;
	my @partes;

	saca "Buscando las particiones...";

	my $sql = "SELECT DISTINCT $funcion "
		. "FROM $tabla "
		. "ORDER BY $funcion";

	my $sth = $dbh -> prepare($sql);
	$sth->execute();

	while ( my @row = $sth->fetchrow_array() ) {
		push (@partes, $row[0]);
	}

	return @partes;
}

sub tomaColumnas {
	my $tabla = $_[0];
	my @columnas = ();

	my $sql = "SELECT Upper(COLUMN_NAME) FROM ALL_TAB_COLUMNS "
		. "WHERE Upper(TABLE_NAME) = ? "
		. "ORDER BY COLUMN_ID";

	my $sth = $dbh->prepare($sql);
	$sth->execute($tabla);

	my $vNomCampo;
	$sth->bind_columns(undef, \$vNomCampo);

	while($sth->fetch()) {
		push(@columnas, $vNomCampo);
	}

	$sth->finish();

	return @columnas;
}

sub exporta {
	my ($tabla, $funcion, $parte, $cabecero) = @_;

	saca "Exportando $parte... ";

	my $sql = "SELECT * FROM $tabla "
		. "WHERE $funcion = ?";

	my $sth = $dbh->prepare($sql);
	$sth->bind_param(1, $parte);
	$sth->execute();

    open ARCHIVO, ">", "$ruta/" . lc($tabla) . "_$parte.txt" 
	    or die "No se puede abrir el archivo " . lc($tabla) . "_$parte.txt: $!";

	print ARCHIVO "$cabecero\n";

	my $cuenta = 0;
	while ( my @row = $sth->fetchrow_array() ) {
		foreach ( @row ) {
			$_ ||= " ";
		}

		print ARCHIVO join("|", @row) . "\n";
		$cuenta++;
	}

	close ARCHIVO;

	print "$cuenta " . pluraliza($cuenta, "registro", "registros")
	      . " " . pluraliza($cuenta, "exportado", "exportados") . "\n";
}

sub pluraliza {
	my ($n, $mensaje, $mensajes) = @_;

	return ($n == 1) ? $mensaje : $mensajes;
}

### Local Variables:
### coding: utf-8-unix
### End:
