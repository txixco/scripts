#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;

# Toma los parámetros
my ($sid, $serial, $status) = ('', '', '');
GetOptions('sid=i' => \$sid, 'serial=i' => \$serial);

if (not $sid) {
	print "Debe especificar el parámetro '--sid'\n";
	exit;
}

if (not $serial) {
	print "Debe especificar el parámetro '--serial'\n";
	exit;
}

my ($base, $schema, $passwd) = tomaParametros();

# Establece la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

# Busca la sesión
my $sql = 'SELECT STATUS '
		. 'FROM SYS.V_$SESSION '
		. "WHERE SID = ? AND SERIAL# = ?";
 
my $sth = $dbh->prepare($sql);
$sth->execute($sid, $serial);
$sth->bind_columns(undef, \$status);

$sth->fetch() or $status = "No se encontró la sesión";
print "$status\n";

# Subrutinas
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
	return ($base, $schema, "$passwd");
}

sub saca {
	print $_[0] . "\n";
}

# Bye
$sth->finish();
$dbh->disconnect;

### Local Variables:
### coding: utf-8-unix
### End:
