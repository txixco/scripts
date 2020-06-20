#!/usr/bin/perl

use strict;
use warnings;
use subs qw(printr);
#use diagnostics;

use Win32::GuiTest qw(GetCursorPos MouseMoveAbsPix);

use constant OFFSET_X => 100;
use constant OFFSET_Y => 100;
use constant WAIT => 60;
use constant SECS => "second" . ((WAIT == 1)?"":"s");

$| = 1; # Set autoflush on

my ($x1, $y1, $x2, $y2) = (0, 0, 0, 0);

print "Moving the mouse every " . WAIT . " " . SECS . "...\n";

while (1) {
    ($x1, $y1) = GetCursorPos();
    ($x2, $y2) = ($x1 + OFFSET_X, $y2 + OFFSET_Y);
    MouseMoveAbsPix( $x2, $y2 );
    sleep 1;
    MouseMoveAbsPix( $x1, $y1 );

    for (my $remains = WAIT; $remains >= 0; $remains--) {
        printr "The next movement will be on $remains " . SECS . "...";
        sleep 1;
    }

    printr "Moviendo...";
}

sub printr {
    my $string = shift;

    print " " x 80 . "\r";
    print "$string\r";
}
