#!/usr/bin/perl

use FindBin;
use lib "$FindBin::Bin";

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle qw(:ora_types);

use IO::Prompt;
use Getopt::Long;

require "dbutils.pl";

# Opciones
my ($tipoOp, $commitEnabled, $anioMes, $funcion);

GetOptions( 'tipoOp=i' => \$tipoOp,
			'commitEnabled=i' => \$commitEnabled,
			'anioMes=s' => \$anioMes,
			'funcion=s' => \$funcion );

#print 'tipoOp = ' . ((defined($tipoOp)) ? $tipoOp 
# 					                    : 'NULL')
#    . ', commitEnabled = ' . ((defined($commitEnabled)) ? $commitEnabled
#                                                        : 'NULL')
#    . ', anioMes = ' . ((defined($anioMes)) ? $anioMes 
#                                            : 'NULL') . "\n";

# Realizamos la conexión
my $dbh = conecta() or die;

# Proceso
my $sth = consulta($tipoOp, $commitEnabled, $anioMes, $funcion);

# Fin de la conexión
END {
	if (defined($dbh)) {
		$dbh->rollback;   # Oracle does a COMMIT when disconnected
		$dbh->disconnect;
	}
}

# Subs
sub saca {
	print $_[0] . "\n";
}

sub consulta {
	my ($tipoOp, $commitEnabled, $anioMes, $funcion) = @_;
    my @parametros;

	if (defined($tipoOp)) {
		push(@parametros, "PNTIPOOP => $tipoOp");
	}

	if (defined($commitEnabled)) {
		push(@parametros, "PNCOMMITENABLED => $commitEnabled");
	}

	if (defined($anioMes)) {
		push(@parametros, "PCANIOMES => $anioMes");
	}

	$funcion = uc($funcion);

	my $params = join(", ", @parametros);

	my $sql = "BEGIN\n\t:curRetorno := $funcion ($params);\nEND;";

    my $curRetorno;

	my $sth = $dbh -> prepare($sql);

	$sth->bind_param_inout( ":curRetorno", \$curRetorno, 0, 
							{ ora_type => ORA_RSET } );

	$sth->execute();

	my ($ultima, $filas) = ('', 0);
	while ( my @row = $curRetorno->fetchrow_array() ) {
		foreach (@row) {
			$_ ||= "\t";
			$ultima .= "$_\t";
		}

		$filas++;
	}

	if ($filas == 1)	{
		saca "$ultima\n";
	} else {
		saca "Hay $filas " . (($filas == 1) ? "fila.\n" : "filas.\n");
	}
}

### Local Variables:
### coding: utf-8-unix
### End:
