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
my ($usuario, $maquina) = ('', '');

GetOptions( 'usuario=s' => \$usuario);
GetOptions( 'maquina=s' => \$maquina);

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Otras variables
my %sesion = ();
my @sesiones = ();
my ($sth, $i, $opcion, $termina) = ('', '', 0, '', 0);
my ($osuser, $machine, $sid, $serial, $sidAct, $serialAct, $status, $actual);

# Establece la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

# Toma la sesión actual, para no mostrarla
($sidAct, $serialAct) = sesionActual();

# Muestra las sesiones
while (not $termina) {
	system $^O eq 'MSWin32' ? 'cls' : 'clear';
	$- = 0;
	@sesiones = ();

	$sth = sesiones($usuario);
	$sth->bind_columns(undef, \$osuser, \$machine, \$sid, \$serial, \$status);

	format STDOUT_TOP =
@>>> @<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<< @>>>>> @>>>>>>> @>>>>>>>>
"", "OSUSER", "MACHINE", "SID", "SERIAL#", "STATUS"
@>>> @<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<< @>>>>> @>>>>>>> @>>>>>>>>
"", "----------", "----------------------", "-----", "-------", "--------"
.

	format STDOUT =
@### @<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<< @##### @####### @>>>>>>>>
$#sesiones+1, $osuser, $machine, $sid, $serial, $status
.

	while($sth->fetch()) {
		next if $sid eq $sidAct && $serial eq $serialAct;
		push(@sesiones, {SID => $sid, SERIAL => $serial});
		write STDOUT;
	}

	$sth->finish();

	print "\n\nIntroduzca la sesión a matar, <r> para refrescar, " 
	        . "<v> para vigilar una sesión o <s> para salir [1]: ";
	chomp($opcion = <>);
	$opcion ||= 1;

	if ($opcion =~ /^\d+$/)	{
		$opcion--;

		$sid = $sesiones[$opcion]{SID};
		$serial = $sesiones[$opcion]{SERIAL};

		muere($sid, $serial);
		next;
	}

	switch (lc($opcion)) {
		case "s" {
			$termina = 1;
			next;
		}
		case "r" {
			next;
		}
		case "v" {
			print "Introduzca la sesión a vigilar [1]: ";
			chomp($opcion = <>);
			$opcion ||= 1;

			$opcion--;

			$sid = $sesiones[$opcion]{SID};
			$serial = $sesiones[$opcion]{SERIAL};

			my $conexion = "$schema/$passwd\@$base";

			system("watch getstatus.pl --sid $sid --serial $serial $conexion");
		}
	}
}

# Bye
$dbh->disconnect;


# Subprogramas
sub sesiones {
	my ($usuario) = @_;
	my $sql = 'SELECT OSUSER, MACHINE, SID, SERIAL#, STATUS '
		. 'FROM SYS.V_$SESSION '
		. 'WHERE SCHEMANAME = ?';

	if ($usuario ne '') {
		$sql .= ' AND OSUSER IN '
			. "('$usuario', 'ELEKTRA\\$usuario', 'GRUPO_ELEKTRA\\$usuario')";
	}

	if ($maquina ne '') {
		$sql .= " AND MACHINE = $maquina";
	}

	$sql .= ' ORDER BY OSUSER, MACHINE';

	my $sth = $dbh->prepare($sql);
	$sth->execute(uc($schema));

	return $sth;
}

sub muere {
	my ($sid, $sesion) = @_;

	print "¡Muere, cochina sesión $sid|$serial!\n";

	my $sql = "begin "
	. "SYS.KILL_SESSION(:nSID, :nSerial); "
	. "exception when others then null; "
	. "end;";

	my $sth = $dbh->prepare($sql);
	$sth->bind_param(":nSID", $sid);
	$sth->bind_param(":nSerial", $serial);
	$sth->execute();
}

sub sesionActual {
	my $sql = 'SELECT SID, SERIAL# '
		 . 'FROM V$SESSION '
		 . "WHERE AUDSID = SYS_CONTEXT('USERENV','SESSIONID')";
 
	my $sth = $dbh->prepare($sql);
	$sth->execute();

	my ($sid, $serial) = ('', '');
	$sth->bind_columns(undef, \$sid, \$serial);

	$sth->fetch();
	$sth->finish();

	return ($sid, $serial);
}

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

sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
