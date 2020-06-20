#! /usr/bin/perl

my ($a, $b) = @ARGV;

print "mcm($a, $b) = " . $a * $b / mcd($a, $b) . "\n";

# Calcula el mcd mediante el algoritmo de euclides
sub mcd {
	my ($a, $b) = @_;

	if ($b eq 0) {
		return $a;
	} else {
		return mcd($b, $a % $b);
	}
}
