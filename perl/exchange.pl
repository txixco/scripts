#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use Email::Folder::Exchange;

use constant URL => 'https://webmail07.west.com/owa';
use constant USER => 'us\frueda';
use constant PASSWD => 'NTRCLL2017gst';

# https://webmail07.west.com/owa
# http://owa.myorg.com/user/Inbox
my $folder = Email::Folder::Exchange->new(URL, USER, PASSWD);

for my $message ($folder->messages) {
    print "subject: " . $message->header('Subject');
}

for my $folder ($folder->folders) {
    print "folder uri: " . $folder->uri->as_string;
    print " contains " . scalar($folder->messages) . " messages";
    print " contains " . scalar($folder->folders) . " folders";
}
