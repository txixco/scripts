use DBI;
use DBD::Oracle;

# Conecta a una base de datos Oracle
sub conecta {
	my ($base, $schema, $passwd) = tomaParametros();
	my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
    	or die "No se pudo conectar: $!";

	$dbh->{AutoCommit}    = 0;
    $dbh->{RaiseError}    = 1;
    $dbh->{ora_check_sql} = 0;
    $dbh->{RowCacheSize}  = 16;

	return $dbh;
}

# Toma de la consola los parámetros necesarios para poder conectar a una base
# de datos Oracle
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

1;

