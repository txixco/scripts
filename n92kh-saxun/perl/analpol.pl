#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;
use Switch;

use constant MAXTBL => 15;
use constant MAXCOL => 15;
use constant MAXIDX => 15;
use constant MAXCNS => 15;

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Otras variables
my @resumen = ();
my %elemento = ();

# Establece la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

# Procesa
@resumen = tablas();

resume(@resumen);

# Bye
$dbh->disconnect;

# Subprogramas
sub tomaParametros {
	my $params = shift @ARGV 
		or die "Se debe especificar la cadena de conexión\n";

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
	return (uc($base), uc($schema), "$passwd");
}

sub tablas {
	my @tablas = ();

	my $sql = 'SELECT TABLE_NAME '
		. 'FROM ALL_TABLES '
		. 'WHERE Upper(owner) = ? '
		. "AND TABLE_NAME NOT LIKE 'BIN\$\%' "
		. "AND TABLE_NAME NOT LIKE '\%PLAN_TABLE\%' "
		. 'ORDER BY TABLE_NAME';

	my $sth = $dbh->prepare($sql);
	$sth->execute($schema);

	my $vNomTabla;
	$sth->bind_columns(undef, \$vNomTabla);

	while($sth->fetch()) {
		if (length($vNomTabla) > MAXTBL) {
			push(@tablas, { TIPO => 'Tabla', 
							OBJ => $vNomTabla, 
							ES => 'Long. ' . length($vNomTabla),
							SER => 'Long. ' . MAXTBL });
		}

#		push(@tablas, columnas($vNomTabla));
		push(@tablas, restricciones($vNomTabla));
		push(@tablas, indices($vNomTabla));
	}

	$sth->finish();
	return @tablas;
}

#sub columnas {
# 	my $tabla = $_[0];
# 	my @columnas = ();
# 
# 	my $sql = 'SELECT column_name FROM all_tab_columns '
# 		. 'WHERE table_name = ? '
# 		. "AND column_name NOT IN ('USUARIO_MODIFICO', 'ULTIMA_MODIFICACION') "
# 		. 'ORDER BY column_name';
# 
# 	my $sth = $dbh->prepare($sql);
# 	$sth->execute($tabla);
# 
# 	my $vNomColumna;
# 	$sth->bind_columns(undef, \$vNomColumna);
# 
# 	while($sth->fetch()) {
# 		if (length($vNomColumna) > MAXTBL) {
# 			push(@columnas, { TIPO => 'Columna', 
# 							OBJ => "$tabla.$vNomColumna", 
# 							ES => 'Long. ' . length($vNomColumna),
# 							SER => 'Long. ' . MAXCOL });
# 		}
# 	}
# 
# 	$sth->finish();
# 	return @columnas;
#}

sub restricciones {
	my $tabla = $_[0];
	my @restricciones = ();

	my $sql = 'SELECT constraint_name FROM all_constraints '
		. 'WHERE table_name = ? '
		. 'ORDER BY constraint_name';

	my $sth = $dbh->prepare($sql);
	$sth->execute($tabla);

	my $vNomRestriccion;
	$sth->bind_columns(undef, \$vNomRestriccion);

	while($sth->fetch()) {
		if (length($vNomRestriccion) > MAXTBL) {
			push(@restricciones, { TIPO => 'Restric.', 
								 OBJ => "$tabla.$vNomRestriccion", 
								 ES => 'Long. ' . length($vNomRestriccion),
								 SER => 'Long. ' . MAXCNS });
		}
	}

	$sth->finish();
	return @restricciones;
}

sub indices {
	my $tabla = $_[0];
	my @indices = ();

	my $sql = 'SELECT index_name, logging FROM all_indexes '
		. 'WHERE table_name = ? '
		. 'ORDER BY index_name';

	my $sth = $dbh->prepare($sql);
	$sth->execute($tabla);

	my ($nombre, $logging);
	
	$sth->bind_columns(undef, \$nombre, \$logging);

	while($sth->fetch()) {
		if (length($nombre) > MAXTBL) {
			push(@indices, { TIPO => 'Indice', 
							 OBJ => "$tabla.$nombre", 
							 ES => 'Long. ' . length($nombre),
							 SER => 'Long. ' . MAXIDX });
		}

		if ($logging eq 'YES') {
			push(@indices, { TIPO => 'Indice', 
							 OBJ => "$tabla.$nombre", 
							 ES => 'LOGGING',
							 SER => 'NOLOGGING' });
		}
	}

	$sth->finish();
	return @indices;
}

sub resume {
	my @resumen = @_;
	my %elemento;

	system $^O eq 'MSWin32' ? 'cls' : 'clear';
	$- = 0;
 
		format STDOUT_TOP =

@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
"-------------------------------------------------------------------------------"
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
"OBJETOS NO CONFORMES A LA POLITICA"
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
"-------------------------------------------------------------------------------"
@<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<< @<<<<<<<<<
"Tipo", "Objeto", "Es", "Debe ser"
@<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<< @<<<<<<<<<
"--------", "-------------------------------------------------", "---------", "---------"
.
 
		format STDOUT =
@<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<... @<<<<<<<<< @<<<<<<<<<
$elemento{TIPO}, $elemento{OBJ}, $elemento{ES}, $elemento{SER}
.

	for (my $i=0; $i < @resumen; $i++) {
		%elemento = %{$resumen[$i]};
		write STDOUT;
	}
}

### Local Variables:
### coding: utf-8-unix
### End:
