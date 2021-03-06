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
               'dates' => [
                            bless( {
                                     '_file' => '(eval 136)',
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     'operator' => 'CODE(...)',
                                     'name' => '<Custom Code>',
                                     '_lines' => [
                                                   11
                                                 ]
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     '_lines' => [
                                                   11
                                                 ],
                                     'operator' => 'CODE(...)',
                                     'name' => '<Custom Code>',
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1979-05-27T07:32:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     '_file' => '(eval 357)'
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     '_lines' => [
                                                   11
                                                 ],
                                     '_file' => '(eval 358)',
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('2006-06-01T11:00:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     'operator' => 'CODE(...)',
                                     'name' => '<Custom Code>'
                                   }, 'Test2::Compare::Custom' )
                          ],
               'strings' => [
                              'a',
                              'b',
                              'c'
                            ],
               'ints' => [
                           bless( {
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
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('1')->beq($_);
                                              },
                                    '_file' => '(eval 359)'
                                  }, 'Test2::Compare::Custom' ),
                           bless( {
                                    '_lines' => [
                                                  6
                                                ],
                                    'operator' => 'CODE(...)',
                                    'name' => '<Custom Code>',
                                    '_file' => '(eval 360)',
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('2')->beq($_);
                                              }
                                  }, 'Test2::Compare::Custom' ),
                           bless( {
                                    'name' => '<Custom Code>',
                                    'operator' => 'CODE(...)',
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('3')->beq($_);
                                              },
                                    '_file' => '(eval 361)',
                                    '_lines' => [
                                                  6
                                                ]
                                  }, 'Test2::Compare::Custom' )
                         ],
               'comments' => [
                               bless( {
                                        '_file' => '(eval 134)',
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigInt;
                                                      'Math::BigInt'->new('1')->beq($_);
                                                  },
                                        'operator' => 'CODE(...)',
                                        'name' => '<Custom Code>',
                                        '_lines' => [
                                                      6
                                                    ]
                                      }, 'Test2::Compare::Custom' ),
                               bless( {
                                        'operator' => 'CODE(...)',
                                        'name' => '<Custom Code>',
                                        '_file' => '(eval 135)',
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigInt;
                                                      'Math::BigInt'->new('2')->beq($_);
                                                  },
                                        '_lines' => [
                                                      6
                                                    ]
                                      }, 'Test2::Compare::Custom' )
                             ],
               'floats' => [
                             bless( {
                                      '_lines' => [
                                                    6
                                                  ],
                                      'code' => sub {
                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                    use strict;
                                                    no feature ':all';
                                                    use feature ':5.16';
                                                    require Math::BigFloat;
                                                    'Math::BigFloat'->new('1.1')->beq($_);
                                                },
                                      '_file' => '(eval 131)',
                                      'name' => '<Custom Code>',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
                                      '_file' => '(eval 132)',
                                      'code' => sub {
                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                    use strict;
                                                    no feature ':all';
                                                    use feature ':5.16';
                                                    require Math::BigFloat;
                                                    'Math::BigFloat'->new('2.1')->beq($_);
                                                },
                                      'operator' => 'CODE(...)',
                                      'name' => '<Custom Code>',
                                      '_lines' => [
                                                    6
                                                  ]
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
                                      '_lines' => [
                                                    6
                                                  ],
                                      '_file' => '(eval 133)',
                                      'code' => sub {
                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x54"}
                                                    use strict;
                                                    no feature ':all';
                                                    use feature ':5.16';
                                                    require Math::BigFloat;
                                                    'Math::BigFloat'->new('3.1')->beq($_);
                                                },
                                      'operator' => 'CODE(...)',
                                      'name' => '<Custom Code>'
                                    }, 'Test2::Compare::Custom' )
                           ]
             };


my $actual = from_toml(q{ints = [1, 2, 3]
floats = [1.1, 2.1, 3.1]
strings = ["a", "b", "c"]
dates = [
  1987-07-05T17:45:00Z,
  1979-05-27T07:32:00Z,
  2006-06-01T11:00:00Z,
]
comments = [
         1,
         2, #this is ok
]
});

is($actual, $expected1, 'arrays - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'arrays - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;