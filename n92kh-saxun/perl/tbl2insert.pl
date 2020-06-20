#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;

# Opciones
my ($sep, $comilla, $tabla) = ('|', '"', '');

GetOptions( 'tabla=s' => \$tabla);

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Realizamos la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";
 
# Procesa
my @campos = tomaColumnas($tabla);
my $cadena = "INSERT INTO $schema.$tabla "
	. "(" . join(", ", @campos) . ")\n";
$cadena .= "VALUES (" . join(", ", parametriza(@campos)) . ");\n";

my $clave = campoClave($tabla);
my $secuencia = tomaSecuencia($tabla);

if ($secuencia) {
	$cadena =~ s/pa$clave/$secuencia.nextval/g;
}

print "$cadena\n";

#Fin de la conexión
$dbh->disconnect;

# Subprogramas
sub tomaSecuencia {
	my $tabla = $_[0];
	my $secuencia = "se" . substr($tabla, 2);
	my $tiene;

	my $sql = "SELECT * FROM all_sequences "
		. "WHERE Lower(sequence_owner) = '$schema' "
		. "AND Lower(sequence_name) = ?";

	my $sth = $dbh->prepare($sql);
	$sth->execute($secuencia);

	$secuencia = ($sth->fetch()) ? $secuencia : "";

	$sth->finish();

	return $secuencia;
}

sub tomaColumnas {
	my $tabla = $_[0];
	my @columnas = ();

	my $sql = "SELECT Lower(column_name) FROM all_tab_columns "
		. "WHERE Lower(table_name) = ? "
		. "ORDER BY column_id";

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

sub parametriza {
	my @campos = @_;
	my @parametros = ();

	for (@campos) {
		push(@parametros, (/d_reg/) ? "SYSDATE" : "pa$_");
	}

	return @parametros;
}

sub campoClave {
	my $tabla = $_[0];
	my $clave;
	my $sql = "SELECT Lower(a.column_name) FROM all_cons_columns a "
		. "JOIN all_constraints c ON (a.constraint_name = c.constraint_name) "
		. "WHERE Lower(c.table_name) = '$tabla' AND c.constraint_type = 'P'";

	my $sth = $dbh->prepare($sql);
	$sth->execute();

	my $vNomCampo;
	$sth->bind_columns(undef, \$vNomCampo);

	while($sth->fetch()) {
		$clave = $vNomCampo;
	}

	$sth->finish();
	return $clave;
}

sub tomaParametros {
	my $params = shift @ARGV;

	my @aux = split('@', $params);
	my $schema = $aux[0] 
		or die "Se debe especificar la cadena de conexión";

	my $base = $aux[1] 
		or die "Se debe especificar la cadena de conexión";

	@aux = split('/', $schema);
	$schema = $aux[0];

	my $passwd = $aux[1] 
		|| prompt("Introduzca la contraseña: ", -e => '*');

	# Algo no anda del todo bien con «prompt»
	return ($base, $schema, "$passwd");
}

sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
