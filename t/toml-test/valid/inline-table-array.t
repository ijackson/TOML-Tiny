# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use DateTime;
use DateTime::Format::RFC3339;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'people' => [
                             {
                               'last_name' => 'Springsteen',
                               'first_name' => 'Bruce'
                             },
                             {
                               'last_name' => 'Clapton',
                               'first_name' => 'Eric'
                             },
                             {
                               'first_name' => 'Bob',
                               'last_name' => 'Seger'
                             }
                           ]
             };


my $actual = from_toml(q{people = [{first_name = "Bruce", last_name = "Springsteen"},
          {first_name = "Eric", last_name = "Clapton"},
          {first_name = "Bob", last_name = "Seger"}]
});

is($actual, $expected1, 'inline-table-array - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'inline-table-array - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;