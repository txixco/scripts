#!/usr/bin/perl

use DBI;
use feature qw(switch say);

# Variables globales
my $dbh;

# Conecta a la base de datos
sub conecta {
	$dbh = DBI->connect("dbi:SQLite:cambios-bda.db", "", "")
       or die "No se pudo conectar: $!";

 	$dbh->{AutoCommit}    = 0;
   $dbh->{RaiseError}    = 1;

   return 1;
}


# Inserta un registro nuevo
sub insertaCambio {
    my ($descripcion, $script, $proyecto) = @_;
    my $sql = 
        "INSERT INTO cambios (descripcion, script, idproyecto, idestatus) "
      . "VALUES ('$descripcion', '$script', $proyecto, 1)";

    $dbh->do($sql);

    $dbh->commit;
}

sub borraCambio {
    my $id = $_[0];
    my $sql = "DELETE FROM cambios WHERE id = $id";

    $dbh->do($sql);

    $dbh->commit;
}

sub inserta {
    my ($tabla, $descripcion) = @_;

    $dbh->do("INSERT INTO $tabla (descripcion) VALUES ('$descripcion')");
    $dbh->commit;
}

sub siguiente {
    my ($id, $nvoEstatus) = @_;
    my ($folio, $descripcion, $script, $proyecto, $estatus, 
        $fecha, $vobo, $comentarios) = ();

    my @filas = tomaFila($id);
    
    if (@filas) {
        my $fila = $filas[0];

        ($id, $folio, $descripcion, $script, $proyecto, $estatus, 
         $fecha, $vobo, $comentarios) = notnuliza(@$fila);
    }

    $estatus = $nvoEstatus || ($estatus+1);

    if ($estatus > 6) {
        return;
    }

    my $campos = "IDESTATUS = $estatus";

    given ($estatus) {
        when (2) {
            $folio = '';
            while (not $folio) {
                $folio = ''
                    || prompt('Introduzca el folio: ');
            }

            $campos .= ", FOLIO = $folio";
        }

        when (4) {
            $fecha = fecha(prompt('Introduzca la fecha (DD/MM/YYYY): '));
            $campos .= ", FECHA_IMPLEMEN = '$fecha'";
        }

        when (/56/) {
            $fecha = fecha(prompt('Introduzca la fecha (DD/MM/YYYY): '));

            my $comentario;
            while (not $comentario) {
                $comentario = ''
                    || prompt('Introduzca un comentario: ');
            }

            $comentarios .= $comentario;
            $campos .= ", FECHA_IMPLEMEN = '$fecha'"
                     . ", COMENTARIOS = $comentarios";
        }
    }

    $dbh->do("UPDATE cambios SET $campos WHERE ID = $id");
    $dbh->commit;
}

sub actualiza {
    my ($id, $columna, $valor) = @_;

say "UPDATE cambios SET $columna = $valor WHERE ID = $id";
    $dbh->do("UPDATE cambios SET $columna = $valor WHERE ID = $id");
    $dbh->commit;
}

sub tomaCambio {
    my $descripcion = $_[0];
    my $sql = "SELECT cmb.id, cmb.folio, cmb.descripcion, cmb.script, "
              . "pry.descripcion, est.descripcion, "
              . "strftime('%d/%m/%Y', cmb.fecha_implemen) , "
              . "cmb.vobo, cmb.comentarios"
           . " FROM cambios cmb"
              . " JOIN proyectos pry ON (cmb.idproyecto = pry.id)"
              . " JOIN estatus est ON (cmb.idestatus = est.id)"
           . " WHERE cmb.descripcion LIKE '%$descripcion%'";

    my $filas = $dbh->selectall_arrayref($sql);

    return @$filas;
}

sub tomaFila {
    my $id = $_[0];
    my $sql = "SELECT id, folio, descripcion, script, idproyecto, idestatus, "
               . "fecha_implemen, vobo, comentarios"
           . " FROM cambios"
           . " WHERE id = $id";

    my $filas = $dbh->selectall_arrayref($sql);

    return @$filas;
}

sub notnuliza {
    my @array = ();

    for (@_) {
        push(@array, $_ || '');
    }

    return @array;
}

sub fecha {
    my $fecha = $_[0];
    if ($fecha) {
        $fecha =~ s/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/$3\/$2\/$1/g;
    } else {
        $fecha = 'CURRENT_DATE';
    }

    return $fecha;
}

# Fin de la conexión
END {
    $dbh->rollback if defined($dbh);
    $dbh->disconnect if defined($dbh);
}

1;
