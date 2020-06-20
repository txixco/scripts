#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use DBI;
use DBD::Oracle;

use IO::Prompt;
use Getopt::Long;

use Text::Template;

use FindBin '$Bin';

use constant INDENT => '   ';

# Variables
my ($texto, $formato, $archivo, $separador, $comillas, $help) = 
   ('', '', '', '|', '', '');

# Opciones
my @tablas = ();

GetOptions( 'tablas=s{,}' => \@tablas,
            'formato=s' => \$formato,
            'archivo' => \$archivo,
            'separador=s' => \$separador,
            'comillas=s' => \$comillas,
            'help' => \$help );

if ($help) {
    print "Uso: ./genera-ctl.pl cadena-de-conexion -f formato-fecha -t tablas "
        . "[-a] [-s separador] [-c comillas]\n";

    exit;
}

# Parametros
my ($base, $schema, $passwd) = tomaParametros();

# Establece la conexión
my $dbh = DBI->connect("dbi:Oracle:$base", $schema, $passwd) 
	or die "No se pudo conectar: $!";

$schema = uc($schema);

# Inicializa la plantilla
my $plantilla = Text::Template->new(SOURCE => "$Bin/genera-ctl.tmpl")
	or die "No se puede abrir la plantilla: $Text::Template::ERROR";

# Para cada tabla
for (@tablas) {
	$_ = uc($_);
	my %vars = ( schema => $schema,
                tabla => $_,
                formato => $formato,
                separador => $separador,
                cadenaColumnas => \&cadenaColumnas,
                ajusta => \&ajusta );

	$texto = $plantilla->fill_in(HASH => \%vars)
		or die "Couldn't fill in template: $Text::Template::ERROR";

	if ($archivo) {
		open ARCHIVO, ">", lc($_) . ".ctl" 
  	        or die "No se puede abrir el archivo " . lc($_) . ".ctl: $!";

		print ARCHIVO "$texto\n";
		close ARCHIVO;
	} else {
		print "$texto\n\n";
	}
}

# Bye
END {
	$dbh->disconnect if defined($dbh);
}

# Subprogramas
 sub cadenaColumnas {
	my ($tabla, $formato) = @_;
	my @columnas = ();
   my $cadenaEnclosed = "";

   if ($comillas) {
       $cadenaEnclosed = ($comillas eq "'") ? "\"'\"" : "'$comillas'";
       $cadenaEnclosed = " ENCLOSED BY $cadenaEnclosed";
   }

	my %tipos = ( "NUMBER" => sub { "DECIMAL EXTERNAL" },
				  "CHAR" => sub { "CHAR$cadenaEnclosed" },
				  "VARCHAR" => sub { "CHAR$cadenaEnclosed" },
				  "VARCHAR2" => sub { "CHAR$cadenaEnclosed" },
				  "TIMESTAMP" => sub { "TIMESTAMP \"$formato\"" },
				  "DATE" => sub { "DATE \"$formato\"" } );

	my %especiales = ( "USUARIO_MODIFICO" => sub { "CONSTANT '753554'" },
                       "ULTIMA_MODIFICACION" => sub { "SYSDATE" } );

	my $sql = "SELECT UPPER (COLUMN_NAME) COLUMN_NAME, DATA_TYPE "
	    . "FROM ALL_TAB_COLUMNS "
		. "WHERE UPPER (TABLE_NAME) = UPPER (?) "
		. "ORDER BY COLUMN_ID";

	my $sth = $dbh->prepare($sql);
	$sth->execute($tabla);

	my ($vNomColumna, $vTipoColumna);
	$sth->bind_columns(undef, \$vNomColumna, \$vTipoColumna);

	while($sth->fetch()) {
        my $columna = $vNomColumna;

        if ($especiales{$vNomColumna}) {
            $columna .= " " . $especiales{$vNomColumna}->();
        } elsif ($tipos{$vTipoColumna}) {
			$columna .= " " . $tipos{$vTipoColumna}->();
        }

		push(@columnas, "$columna");
	}

	$sth->finish();

	return join (', ', @columnas);
}

sub tomaLongitudMaxima {
	my @elementos = @_;
	my $max = 0;

	for (@elementos) {
		if (length($_) > $max) {
			$max = length($_);
		}
	}

	return $max;
}

sub alinea {
	my ($cadena, $ancho) = @_;
	my $n = $ancho - length($cadena);

	for (my $i=0; $i<$n; $i++) {
		$cadena .= " ";
	}

	return $cadena;
}

sub ajusta {
	my ($margen, $sep, $cadena, $unoxlinea) = @_;
	my ($retorno, $subcadena, $maxlen) = ('', '', 80 - $margen);

	$margen = ' ' x $margen;

	if (length($cadena) < $maxlen) {
		$retorno = $cadena;
	} else {
		my @arreglo = split($sep, $cadena);
		for (@arreglo) {
			if ($unoxlinea 
				|| length($subcadena) + length($sep) + length($_) > $maxlen) {
				$retorno .= "$subcadena\n$margen";
				$subcadena = '';
			}

			$subcadena .= "$_, ";
		}
	}

	$retorno .= $subcadena;
	$retorno =~ s/$sep$//;
	$retorno =~ s/^\s+//;

	return $retorno;
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
	return ($base, $schema, "$passwd");
}

sub saca {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
