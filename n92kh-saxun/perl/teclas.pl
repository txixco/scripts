#! /usr/bin/perl

use strict;
use warnings;
use diagnostics;

use X11::GUITest qw/
					   StartApp
					   WaitWindowViewable
					   SendKeys
				   /;

# Start gedit application
StartApp('gedit');

# Wait for application window to come up and become viewable. 
my ($GEditWinId) = WaitWindowViewable('gedit');
if (!$GEditWinId)
{
    die("Couldn't find gedit window in time!");
}

print "Abierta $GEditWinId\n";

# Send text to it
my $result = SendKeys("Hello, how are you?\n");

print "Enviado texto: $result\n";

# Close Application (Alt-f, q).
$result = SendKeys('^(q)');

print "Cerrar: $result\n";

# Handle gedit's Question window if it comes up when closing.  Wait
# at most 5 seconds for it.
if (WaitWindowViewable('Question', undef, 5))
{
    # DoN't Save (Alt-n)
    $result = SendKeys('%(n)');
}

print "Cerrado: $result\n";

#use X11::Xlib;
#my $display = X11::Xlib->new();
# 
#do
#{
# 	
#} until ($display->XQueryKeymap);
# 
#for ($display->XQueryKeymap) {
# 	print XKeysymToString($_) . "\n";
#}
