#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use IO::Prompt;
use Config::Simple;
use Win32::OLE;

# Parametros
my $cfg = new Config::Simple('updateqc.cfg');
my ($user, $passwd, $path, $expr, $field, $value) = getParameters();

# Return a connection with Test Director via the TD Object.
my $tdc = Win32::OLE->new('TDapiole80.TDconnection');
if (!$tdc) {
    die "Cannot start TestDirector object";
}

# Connect to specified server and project.
$tdc->InitConnectionEx($cfg->param('Server'));
$tdc->Login($user , $passwd);
$tdc->Connect($cfg->param('Domain'), $cfg->param('Project'));

# Do it
#$tree_manager = $tdc->TreeManager

# Set the path, folder, test set and test navigation.
$path = $cfg->param('Path') . '\\' . $path;
print "PATH: " . $path . "\n";
my $treeManager = $tdc->TreeManager;
my $node = $treeManager->NodeByPath($path);
my $filter = $node->testFactory->Filter;

# Instantiate filtered test item list for current test set item.
my $testCase = $filter->NewList;

# Go with it
for (my $i = 1; $i <= $testCase->Count; $i++) {
    print "* " . $testCase->Item($i)->Field('TS_NAME') . "\n";

    my $description = $testCase->Item($i)->Field('TS_DESCRIPTION');
    my @jiras = ($description =~ /(RES-[0-9]+|NoSComp)/g);
    my $jira = join(' ', @jiras);
    @jiras = ($description =~ /Requirement: ?([0-9. ]+)/);
    
    if (@jiras && $jiras[0] ne ' ') {
        $jira .= "; Requirement " . join(' ', @jiras);
    }

    print "\t$jira\n";

    print "\n";
}

# Subprogramas
sub getParameters {
    my ($user, $passwd, $path, $field, $value, $expr);

    $user = 'frueda';#prompt("User: ");
	 $passwd = 'HPLM101cm';#prompt("Password: ", -e => '*');
	 $path = 'Owner\\Owner - Navigation';#prompt("Path: ");
	 $expr = '';#prompt("Expression: ");
	 $field = 'Designer';#prompt("Field [Designer]: ", -d => 'Designer');

    if (lc($field) eq "designer") {
        $value = $user;#prompt("Value [$user]: ", -d => $user);
    } else {
        $value = prompt("Value: ");
    }

    # Something is not totally ok with prompt
    return ($user, "$passwd", $path, $expr, $field, $value);
}

sub println {
	print $_[0] . "\n";
}

### Local Variables:
### coding: utf-8-unix
### End:
