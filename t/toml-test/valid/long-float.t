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
               'longpi' => bless( {
                                    '_lines' => [
                                                  6
                                                ],
                                    '_file' => '(eval 421)',
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigFloat;
                                                  'Math::BigFloat'->new('3.141592653589793')->beq($_);
                                              },
                                    'name' => '<Custom Code>',
                                    'operator' => 'CODE(...)'
                                  }, 'Test2::Compare::Custom' ),
               'neglongpi' => bless( {
                                       '_lines' => [
                                                     6
                                                   ],
                                       'name' => '<Custom Code>',
                                       'operator' => 'CODE(...)',
                                       'code' => sub {
                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                     use strict;
                                                     no feature ':all';
                                                     use feature ':5.16';
                                                     require Math::BigFloat;
                                                     'Math::BigFloat'->new('-3.141592653589793')->beq($_);
                                                 },
                                       '_file' => '(eval 420)'
                                     }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{longpi = 3.141592653589793
neglongpi = -3.141592653589793
});

is($actual, $expected1, 'long-float - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'long-float - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;