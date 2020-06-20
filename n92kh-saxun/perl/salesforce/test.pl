use Data::Random qw(:all);

my @random_array = rand_words( size => 10 );
print @random_array . "\n";

my @random_array = rand_chars( set => 'all', min => 5, max => 8 );
print @random_array . "\n";

my $random_string       = rand_chars( set => 'all', min => 5, max => 8 );
print "$random_string\n";

my @random_array = rand_set( set => \@random_array, size => 5 );
print "$random_string\n";

my $random_string = rand_enum( set => \@random_array );
print "$random_string\n";

my $random_string = rand_date();
print "$random_string\n";

my $random_string = rand_time();
print "$random_string\n";

my $random_string = rand_datetime();
print "$random_string\n";
