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
               '~!@$^&*()_+-`1234567890[]|/?><.,;:\'' => bless( {
                                                                  'operator' => 'CODE(...)',
                                                                  'name' => '<Custom Code>',
                                                                  'code' => sub {
                                                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                                                use strict;
                                                                                no feature ':all';
                                                                                use feature ':5.16';
                                                                                require Math::BigInt;
                                                                                'Math::BigInt'->new('1')->beq($_);
                                                                            },
                                                                  '_file' => '(eval 413)',
                                                                  '_lines' => [
                                                                                6
                                                                              ]
                                                                }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{"~!@$^&*()_+-`1234567890[]|/?><.,;:'" = 1
});

is($actual, $expected1, 'key-special-chars - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'key-special-chars - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;