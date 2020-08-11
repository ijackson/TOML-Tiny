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
               'a' => {
                        'better' => bless( {
                                             '_file' => '(eval 342)',
                                             'code' => sub {
                                                           BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                           use strict;
                                                           no feature ':all';
                                                           use feature ':5.16';
                                                           require Math::BigInt;
                                                           'Math::BigInt'->new('43')->beq($_);
                                                       },
                                             'name' => '<Custom Code>',
                                             '_lines' => [
                                                           6
                                                         ],
                                             'operator' => 'CODE(...)'
                                           }, 'Test2::Compare::Custom' ),
                        'b' => {
                                 'c' => {
                                          'answer' => bless( {
                                                               '_file' => '(eval 343)',
                                                               'code' => sub {
                                                                             BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                             use strict;
                                                                             no feature ':all';
                                                                             use feature ':5.16';
                                                                             require Math::BigInt;
                                                                             'Math::BigInt'->new('42')->beq($_);
                                                                         },
                                                               'name' => '<Custom Code>',
                                                               'operator' => 'CODE(...)',
                                                               '_lines' => [
                                                                             6
                                                                           ]
                                                             }, 'Test2::Compare::Custom' )
                                        }
                               }
                      }
             };


my $actual = from_toml(q{[a.b.c]
answer = 42

[a]
better = 43
});

is($actual, $expected1, 'implicit-and-explicit-after - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'implicit-and-explicit-after - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag '';
  diag 'REPARSED OUTPUT:';
  diag Dumper(scalar from_toml(to_toml($actual)));
};

done_testing;