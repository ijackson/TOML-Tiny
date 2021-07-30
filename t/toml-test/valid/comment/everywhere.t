# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'group' => {
                            'answer' => bless( {
                                                 '_file' => '(eval 155)',
                                                 '_lines' => [
                                                               7
                                                             ],
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigInt;
                                                               my $got = 'Math::BigInt'->new($_);
                                                               'Math::BigInt'->new('42')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("42")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' ),
                            'd' => '1979-05-27T07:32:12-07:00',
                            'more' => [
                                        bless( {
                                                 '_file' => '(eval 153)',
                                                 '_lines' => [
                                                               7
                                                             ],
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigInt;
                                                               my $got = 'Math::BigInt'->new($_);
                                                               'Math::BigInt'->new('42')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("42")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' ),
                                        bless( {
                                                 '_file' => '(eval 154)',
                                                 '_lines' => [
                                                               7
                                                             ],
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigInt;
                                                               my $got = 'Math::BigInt'->new($_);
                                                               'Math::BigInt'->new('42')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("42")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                                      ]
                          }
             };


my $actual = from_toml(q|# Top comment.
  # Top comment.
# Top comment.

# [no-extraneous-groups-please]

[group] # Comment
answer = 42 # Comment
# no-extraneous-keys-please = 999
# Inbetween comment.
more = [ # Comment
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
  42, 42, # Comments within arrays are fun.
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
# ] Did I fool you?
] # Hopefully not.

# Make sure the space between the datetime and "#" isn't lexed.
d = 1979-05-27T07:32:12-07:00  # c
|);

is($actual, $expected1, 'comment/everywhere - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'comment/everywhere - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'comment/everywhere - to_toml') or do{
  diag "ERROR: $error" if $error;

  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag Dumper($regenerated);

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper($reparsed);
};

done_testing;