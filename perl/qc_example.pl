#!/usr/bin/perl

use strict;
use Data::Dumper;

# Instantiate counter vars.
my ($i, $j, $k);

# Return a connection with Test Director via the TD Object.
eval 'use Win32::OLE';
die "Unable to load Win32::OLE module: $@\n" if $@;
my $tdc = Win32::OLE->new('TDapiole80.TDconnection');
if (!$tdc) {
    die "Cannot start TestDirector object";
}

# Connect to specified server and project.
$tdc->InitConnectionEx("http://YOUR_QCSERVER:8080/qcbin");
$tdc->Login("YOUR_USERNAME" , "YOUR_PASSWORD"); # <==== EDIT THESE . . .
$tdc->Connect("YOUR_DOMAIN", "YOUR_PROJECT");

# Set the path, folder, test set and test navigation.
my $path = 'Root\Automation';
print "\nPATH: " . $path;
my $QCtstm = $tdc->{TestSetTreeManager};
my $TestSetFolder = $QCtstm->NodeByPath($path);
my $tsff = $TestSetFolder->TestSetFactory->Filter;

# Instantiate filtered test set list for folder path.
my $tsl = $tsff->NewList;
print "\nSET COUNT: " . $tsl->Count;
for ($i = 1; $i <= $tsl->Count; $i++) {
    print "\n\tTEST SET: " . $tsl->Item($i)->Field('CY_CYCLE');
    my $ts = $tsl->Item($i);
    my $tstff = $ts->TSTestFactory->Filter;

    # Instantiate filtered test item list for current test set item.
    my $tcase = $tstff->NewList;
    print "\n\tTEST COUNT: " . $tcase->Count;

    # Share each test test item with us. ;o) 
    for ($j = 1; $j <= $tcase->Count; $j++)
    {
        print "\n\t\tTEST ITEM: " . $tcase->Item($j)->Field('TS_NAME'); 

        # Get DTM / Automation raw values posted to item record by QCToolbox and Automation Testing Lab...
        print "\nDISCLOSURE RESULTS : " . $tcase->Item($j)->Field('TC_USER_25');

        # Prepare and POST test instance field value(s)...
        my $tstInstance = $tcase->Item($j);
        my $runf = $tstInstance->RunFactory;

        # Get DTM / Automation log file attachments for item record 
        my $tsTmp = $tcase->Item($j);
        my $attachFact = $tsTmp->Attachments;
        my $attachList = $attachFact->NewList("");
        print "\n\tATTACH COUNT: " . $attachList->Count;
        for ($k = 1; $k <= $attachList->Count; $k++)
        {
            print "\n\t\tFILE NAME: " . $attachList->Item($k)->FileName;
            # my $TestAttachStorage = .AttachmentStorage;
            # my $TestAttachStorage->ClientPath = "c:\temp\QCT\" . theTest.Name . "\attachStorage";
            # $TAttach->Load;
        }
    }
}
