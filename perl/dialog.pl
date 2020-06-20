#!/usr/bin/perl

use Tk::Dialog;

for (@ARGV) {
    $d=$mw->Dialog( -title => "Directory", 
                    -text  => $_ );

    $d->Show; 
}

### Local Variables:
### coding: utf-8-unix
### End:
