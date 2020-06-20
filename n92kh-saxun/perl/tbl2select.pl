#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;

require dbutils.pl

# Opciones
my ($sep, $comilla) = ('|', '"');
my @tablas = ();

GetOptions( 'separador=s' => \$sep, 
			'comilla=s' => \$comilla,
			'tablas=s{,}' => \@tablas);

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Realizamos la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

# Procesa
for (@tablas) {
	my $sth = $dbh->column_info(undef, $schema, $_, undef);
 
	my $columna = "";
	my $tipo = "";
	my @columnas = tomaColumnas($_);

	my $temp = join(" || $comilla$sep$comilla || ", @columnas);
	my $sql = "SELECT $temp FROM $_;";

	print "$sql\n";
}
 
#Fin de la conexión
$dbh->disconnect;

sub tomaColumnas {
	my $tabla = $_;
	my @campos = ();

	my $sql = "SELECT Lower(column_name) FROM all_tab_columns "
		. "WHERE Lower(table_name) = ? "
		. "ORDER BY column_id";

	my $sth = $dbh->prepare($sql);
	$sth->execute($tabla);

	my $vNomCampo;
	$sth->bind_columns(undef, \$vNomCampo);

	while($sth->fetch()) {
		push(@campos, $vNomCampo);
	}

	$sth->finish();

	return @campos;
}

sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
