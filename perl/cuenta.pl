#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;
use Switch;

# Opciones
my $tabla = '';

GetOptions( 'tabla=s' => \$tabla);

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Otras variables
my ($n, $sth, $sql) = (1, '', '');

# Establece la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

# Vigila
while () {
	my $sql = "SELECT COUNT(*) FROM $tabla";
	my $sth = $dbh->prepare($sql);

	$sth->execute();
	$sth->bind_columns(undef, \$n);

	if ($sth->fetch()) {
		system $^O eq 'MSWin32' ? 'cls' : 'clear';
		print "$tabla\nFilas: $n\n";
	}

	sleep(1);
}

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

### Local Variables:
### coding: utf-8-unix
### End:
