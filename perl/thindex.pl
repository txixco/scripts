#! /usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use LWP::Simple;
use HTML::TreeBuilder::XPath;

use constant MODULES => '//div[contains(@class, "trail-module-item")]';
use constant UNITS => '//ul[contains(@class, "module-units-list")]//li//a';
use constant ITEMS => '//ul[contains(@class, "trailhead-child-items")]//li//a';

# Let's go
my $url = shift(@ARGV);
my $content = get($url) or die "Couldn't get $url\n";
my $tree= HTML::TreeBuilder::XPath->new_from_content($content);

printf("** [[%s][%s]]\n", 
       $tree->findvalue('//meta[@property="og:url"]/@content'), 
       $tree->findvalue('//meta[@property="og:title"]/@content'));
 
if ($tree->exists(MODULES)) {
    printModules();
} else {
    printElements($tree, UNITS);
    printElements($tree, ITEMS);
}
 
# Bye
$tree->delete;        # to avoid memory leaks, if you parse many HTML documents 

# Subprogramas
sub trim {
    foreach (@_) {
        s/^\s+//;
        s/\s+$//;
    }

    return @_;
}

sub printModules {
    foreach ($tree->findnodes(MODULES)) {
        my $url = 'https://trailhead.salesforce.com' . 
                  $_->findvalue('.//h3//a//@href');

        my $title = $_->findvalue('.//h3//a//text()');

        printf("*** [[%s][%s]]\n", $url, $title);
	printElements($_, '.' . UNITS, 2);
	printElements($_, '.' . ITEMS, 2); 
    }
}

sub printElements {
    my ($root, $xpath, $level) = @_;

    $level = $level || 1;

    foreach ($root->findnodes($xpath)) {
        my $url = 'https://trailhead.salesforce.com' . 
                  $_->findvalue('.//@href');
        foreach ($_->findvalue('.//div[not(@class)]')) {
            printf("%s- [[%s][%s]]\n", '  ' x $level, $url, trim($_));
        }
    }
}
