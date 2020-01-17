# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'a' => [
                        {
                          'b' => [
                                   {
                                     'c' => {
                                              'd' => 'val0'
                                            }
                                   },
                                   {
                                     'c' => {
                                              'd' => 'val1'
                                            }
                                   }
                                 ]
                        }
                      ]
             };


my $actual = from_toml(q{[[a]]
    [[a.b]]
        [a.b.c]
            d = "val0"
    [[a.b]]
        [a.b.c]
            d = "val1"
});

is($actual, $expected1, 'table-array-table-array - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'table-array-table-array - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;