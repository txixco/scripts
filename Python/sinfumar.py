#!/usr/bin/env python

'''
Calculates the time since I quit from smoking. It could be a script to
calculate date differences, but I wanted to hardcode the first time.

This script takes into account for the time zone, as I want it to be more
accurate if I move from the current time zone.
'''

from datetime import datetime

# The UTC quitting date :-) and now
quitDate = datetime."28-02-2012 14:20"
now = datetime.now()

my @QUIT_DATE = (2012, 3, 9, 14, 20, 0);
my @now = Gmtime();

# Go
my @result = Delta_YMDHMS(@QUIT_DATE,
						  $now[0], $now[1], $now[2], $now[3], $now[4], $now[5]);
my $out = "";

for (@ARGV) {
	for ($_) {
		/^-y/ and do { $out .= "$result[0] "; };
		/^-M/ and do { $out .= "$result[1] "; };
		/^-d/ and do { $out .= "$result[2] "; };
		/^-h/ and do { $out .= "$result[3] "; };
		/^-m/ and do { $out .= "$result[4] "; };
		/^-s/ and do { $out .= "$result[5] "; };
		/^-a/ and do { $out = human(@result); last; };
		/^-x/ and do { $out = "Sigo fumando..."; };
		/^.$/ and do { $out = helpMessage(); last; }
	}
}

if ($out eq "")	{
	$out = helpMessage();
}

print "$out\n";

sub helpMessage {
	return "Usage: sinfumar.pl {-y|-M|-d|-h|-m|-s}";
}

sub human {
	my @result = @_;
	my $return = "";
	my $i = 0;

	for (@result) {
		if ($_ > 0) {
			$return .= "$_ ";

			for ($i) {
				/^0/ and do { $return .= "año"; };
				/^1/ and do { $return .= "mes"; };
				/^2/ and do { $return .= "día"; };
				/^3/ and do { $return .= "hora"; };
				/^4/ and do { $return .= "minuto"; };
				/^5/ and do { $return .= "segundo"; };
			}

			if ($_ > 1) {
				$return .= ($i == 1) ? "es" : "s";
			}

			$return .= ", ";
		}

		$i++;
	}

	if ($return eq "") {
		return "Sigo fumando...";
	}

	$return =~ s/, $//;
	$return =~ s/(.*),/$1 y/;

	return "$return";
}
