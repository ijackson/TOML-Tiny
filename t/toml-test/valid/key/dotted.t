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
               'a' => {
                        'few' => {
                                   'dots' => {
                                               'polka' => {
                                                            'dance-with' => 'Dot',
                                                            'dot' => 'again?'
                                                          }
                                             }
                                 }
                      },
               'arr' => [
                          {
                            'a' => {
                                     'b' => {
                                              'c' => bless( {
                                                              '_file' => '(eval 278)',
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
                                                                            'Math::BigInt'->new('1')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("1")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' ),
                                              'd' => bless( {
                                                              '_file' => '(eval 277)',
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
                                                                            'Math::BigInt'->new('2')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("2")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   }
                          },
                          {
                            'a' => {
                                     'b' => {
                                              'c' => bless( {
                                                              '_file' => '(eval 280)',
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
                                                                            'Math::BigInt'->new('3')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("3")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' ),
                                              'd' => bless( {
                                                              '_file' => '(eval 279)',
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
                                                                            'Math::BigInt'->new('4')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("4")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   }
                          }
                        ],
               'count' => {
                            'a' => bless( {
                                            '_file' => '(eval 273)',
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
                                                          'Math::BigInt'->new('1')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("1")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'b' => bless( {
                                            '_file' => '(eval 274)',
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
                                                          'Math::BigInt'->new('2')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("2")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'c' => bless( {
                                            '_file' => '(eval 272)',
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
                                                          'Math::BigInt'->new('3')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("3")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'd' => bless( {
                                            '_file' => '(eval 269)',
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
                                                          'Math::BigInt'->new('4')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("4")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'e' => bless( {
                                            '_file' => '(eval 267)',
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
                                                          'Math::BigInt'->new('5')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("5")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'f' => bless( {
                                            '_file' => '(eval 265)',
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
                                                          'Math::BigInt'->new('6')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("6")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'g' => bless( {
                                            '_file' => '(eval 270)',
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
                                                          'Math::BigInt'->new('7')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("7")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'h' => bless( {
                                            '_file' => '(eval 268)',
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
                                                          'Math::BigInt'->new('8')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("8")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'i' => bless( {
                                            '_file' => '(eval 266)',
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
                                                          'Math::BigInt'->new('9')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("9")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'j' => bless( {
                                            '_file' => '(eval 275)',
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
                                                          'Math::BigInt'->new('10')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("10")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'k' => bless( {
                                            '_file' => '(eval 271)',
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
                                                          'Math::BigInt'->new('11')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("11")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'l' => bless( {
                                            '_file' => '(eval 276)',
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
                                                          'Math::BigInt'->new('12')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("12")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' )
                          },
               'many' => {
                           'dots' => {
                                       'here' => {
                                                   'dot' => {
                                                              'dot' => {
                                                                         'dot' => bless( {
                                                                                           '_file' => '(eval 263)',
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
                                                                       }
                                                            }
                                                 }
                                     }
                         },
               'name' => {
                           'first' => 'Arthur',
                           'last' => 'Dent'
                         },
               'tbl' => {
                          'a' => {
                                   'b' => {
                                            'c' => bless( {
                                                            '_file' => '(eval 264)',
                                                            '_lines' => [
                                                                          7
                                                                        ],
                                                            'code' => sub {
                                                                          BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                          use strict;
                                                                          no feature ':all';
                                                                          use feature ':5.16';
                                                                          require Math::BigFloat;
                                                                          my $got = 'Math::BigFloat'->new($_);
                                                                          'Math::BigFloat'->new('42.666')->beq($got);
                                                                      },
                                                            'name' => 'Math::BigFloat->new("42.666")->beq($_)',
                                                            'operator' => 'CODE(...)'
                                                          }, 'Test2::Compare::Custom' )
                                          }
                                 }
                        }
             };


my $actual = from_toml(q|# Note: this file contains literal tab characters.

name.first = "Arthur"
"name".'last' = "Dent"

many.dots.here.dot.dot.dot = 42

# Space are ignored, and key parts can be quoted.
count.a       = 1
count . b     = 2
"count"."c"   = 3
"count" . "d" = 4
'count'.'e'   = 5
'count' . 'f' = 6
"count".'g'   = 7
"count" . 'h' = 8
count.'i'     = 9
count 	.	 'j'	   = 10
"count".k     = 11
"count" . l   = 12

[tbl]
a.b.c = 42.666

[a.few.dots]
polka.dot = "again?"
polka.dance-with = "Dot"

[[arr]]
a.b.c=1
a.b.d=2

[[arr]]
a.b.c=3
a.b.d=4
|);

is($actual, $expected1, 'key/dotted - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'key/dotted - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'key/dotted - to_toml') or do{
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