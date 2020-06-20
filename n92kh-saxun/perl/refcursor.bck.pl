#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle qw(:ora_types);

use IO::Prompt;
use Getopt::Long;

require "dbutils.pl";

# Opciones
my ($tipoOp, $commitEnabled, $anioMes);

GetOptions( 'tipoOp=i' => \$tipoOp );
GetOptions( 'commitEnabled=i' => \$commitEnabled );
GetOptions( 'anioMes=s' => \$anioMes );

print 'tipoOp = ' . ((defined($tipoOp)) ? $tipoOp 
					                    : 'NULL')
    . ', commitEnabled = ' . ((defined($commitEnabled)) ? $commitEnabled
                                                        : 'NULL')
    . ', anioMes = ' . ((defined($anioMes)) ? $anioMes 
                                            : 'NULL') . "\n";

# Realizamos la conexión
my $dbh = conecta() or die;

# Proceso
my $sth = consulta($tipoOp, $commitEnabled, $anioMes);

# Fin de la conexión
END {
	$dbh->disconnect if defined($dbh);
}

# Subs
sub saca {
	print $_[0] . "\n";
}

sub consulta {
	my ($tipoOp, $commitEnabled, $anioMes) = @_;

	my $sql = "
BEGIN
  :curRetorno := FNPASO_PASTKPOLC (PNTIPOOP => :nTipoOp,
                                   PNCOMMITENABLED => :nCommitEnabled,
                                   PCANIOMES => :cAnioMes);
END;";

    my $curRetorno;

	my $sth = $dbh -> prepare($sql);

	$sth->bind_param( ":nTipoOp", $tipoOp);
	$sth->bind_param( ":nCommitEnabled", $commitEnabled);
	$sth->bind_param( ":cAnioMes", $anioMes);
	$sth->bind_param_inout( ":curRetorno", \$curRetorno, 0, 
							{ ora_type => ORA_RSET } );

	$sth->execute();

	while ( my @row = $curRetorno->fetchrow_array() ) {
		foreach (@row) {
			$_ ||= "\t";
			print "$_\t";
		}
		print "\n";
	}
}

### Local Variables:
### coding: utf-8-unix
### End:
