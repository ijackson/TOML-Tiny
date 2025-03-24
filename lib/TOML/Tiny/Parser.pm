package TOML::Tiny::Parser;
# ABSTRACT: parser used by TOML::Tiny

use utf8;
use strict;
use warnings;
no warnings qw(experimental);
use v5.18;

use Carp qw(confess);
use Data::Dumper qw(Dumper);
use Encode qw(decode FB_CROAK);
use Math::BigFloat ();
use Math::BigInt ();
use TOML::Tiny::Grammar qw($TimeOffset);
use TOML::Tiny::Tokenizer ();

our $TRUE  = 1;
our $FALSE = 0;

eval{
  require Types::Serialiser;
  $TRUE = Types::Serialiser::true();
  $FALSE = Types::Serialiser::false();
};

sub new {
  my ($class, %param) = @_;
  bless{
    inflate_integer  => $param{inflate_integer},
    inflate_float    => $param{inflate_float},
    inflate_datetime => $param{inflate_datetime} || sub{ shift },
    inflate_boolean  => $param{inflate_boolean}  || sub{ shift eq 'true' ? $TRUE : $FALSE },
    strict           => $param{strict},
  }, $class;
}

sub next_token {
  my $self = shift;
  my $token = $self->{tokenizer} && $self->{tokenizer}->next_token;
  return $token;
}

sub parse {
  my ($self, $toml) = @_;

  if ($self->{strict}) {
    $toml = decode('UTF-8', "$toml", FB_CROAK);
  }

  $self->{tokenizer}    = TOML::Tiny::Tokenizer->new(source => $toml);
  $self->{keys}         = [];
  $self->{root}         = {};
  $self->{tables}       = {}; # "seen" hash of explicitly defined table names (e.g. [foo])
  $self->{arrays}       = {}; # "seen" hash of explicitly defined static arrays (e.g. foo=[])
  $self->{array_tables} = {}; # "seen" hash of explicitly defined arrays of tables (e.g. [[foo]])

  $self->parse_table;
  my $result = $self->{root};

  delete $self->{tokenizer};
  delete $self->{keys};
  delete $self->{root};
  delete $self->{tables};
  delete $self->{arrays};
  delete $self->{array_tables};

  return $result;
}

sub parse_error {
  my ($self, $token, $msg) = @_;
  my $line = $token ? $token->{line} : 'EOF';
  if ($ENV{TOML_TINY_DEBUG}) {
    my $root = Dumper($self->{root});
    my $tok  = Dumper($token);
    my $src  = substr $self->{tokenizer}{source}, $self->{tokenizer}{position}, 30;

    confess qq{
toml parse error at line $line:
    $msg

Current token:
$tok

Parse state:
$root

Source near location of error:
...
$src
...

    };
  } else {
    die "toml parse error at line $line: $msg\n";
  }
}

sub expect_type {
  my ($self, $token, $expected) = @_;
  my $actual = $token ? $token->{type} : 'EOF';
  $self->parse_error($token, "expected $expected, but found $actual")
    unless $actual =~ /$expected/;
}


sub current_key {
  my $self = shift;
  my @keys = $self->get_keys;
  my $key  = join '.', map{ qq{"$_"} } @keys;
  return $key;
}

sub push_keys {
  my ($self, $token) = @_;
  push @{ $self->{keys} }, $token->{value};
}

sub pop_keys {
  my $self = shift;
  pop @{ $self->{keys} };
}

sub get_keys {
  my $self = shift;
  return map{ @$_ } @{ $self->{keys} };
}

sub set_key {
  my ($self, $token) = @_;
  my @keys = $self->get_keys;
  my $key  = pop @keys;
  my $node = $self->scan_to_key(\@keys);

  if ($key && exists $node->{$key}) {
    $self->parse_error($token, 'duplicate key: ' . $self->current_key);
  }

  $node->{$key} = $self->parse_value($token);
}

sub declare_key {
  my ($self, $token) = @_;
  my $key = $self->current_key || return;

  if ($token->{type} eq 'inline_array') {
    $self->parse_error($token, "duplicate key: $key")
      if exists $self->{array_tables}{$key};

    $self->{arrays}{$key} = 1;
    return;
  }

  if ($token->{type} eq 'array_table') {
    if (exists $self->{arrays}{$key}) {
      $self->parse_error($token, "duplicate key: $key");
    }

    $self->{array_tables}{$key} = 1;
    return;
  }

  if ($token->{type} eq 'table') {
    $self->parse_error($token, "duplicate key: $key")
      if exists $self->{arrays}{$key}
      || exists $self->{array_tables}{$key};

    if (exists $self->{tables}{$key}) {
      # Tables cannot be redefined, *except* when doing so within a goddamn
      # table array. Gawd I hate TOML.
      my $in_a_stupid_table_array = 0;
      my $node = $self->{root};

      for my $key ($self->get_keys) {
        if (exists $node->{$key} && ref($node->{$key}) eq 'ARRAY') {
          $in_a_stupid_table_array = 1;
          last;
        } else {
          $node = $node->{$key};
        }
      }

      unless ($in_a_stupid_table_array) {
        $self->parse_error($token, "duplicate key: $key");
      }
      return;
    }
    $self->{tables}{$key} = 1;
  }
}

sub scan_to_key {
  my $self = shift;
  my $keys = shift // [ $self->get_keys ];
  my $node = $self->{root};

  KEY:
  for my $key (@$keys) {
    if (exists $node->{$key}) {
      my $ref = ref $node->{$key};
      if ( $ref eq 'HASH' ) {
        $node = $node->{$key};
        next KEY;
      }
      if ( $ref eq 'ARRAY' ) {
        $node = $node->{$key}[-1];
        next KEY;
      }
      my $full_key = join '.', @$keys;
      die "$full_key is already defined\n";
    }
    else {
      $node = $node->{$key} = {};
    }
  }

  return $node;
}

sub parse_table {
  my $self  = shift;
  my $token = shift // $self->next_token // return; # may be undef on first token in empty document

  $self->expect_type($token, 'table');
  $self->push_keys($token);
  $self->scan_to_key;

  $self->declare_key($token);

  TOKEN: while (my $token = $self->next_token) {
    my $type = $token->{type};
    next TOKEN if $type eq 'EOL';

    if ( $type eq 'key') {
      $self->expect_type($self->next_token, 'assign');
      $self->push_keys($token);
      $self->set_key($self->next_token);
      $self->pop_keys;

      if (my $eol = $self->next_token) {
        $self->expect_type($eol, 'EOL');
      } else {
        return;
      }
      next TOKEN;
    }

    if ($type eq 'array_table') {
      $self->pop_keys;
      @_ = ($self, $token);
      goto \&parse_array_table;
    }

    if ( $type eq 'table') {
      $self->pop_keys;
      @_ = ($self, $token);
      goto \&parse_table;
    }

    $self->parse_error($token, "expected key-value pair, table, or array of tables but got $type");
  }
}

sub parse_array_table {
  my $self  = shift;
  my $token = shift // $self->next_token;
  $self->expect_type($token, 'array_table');
  $self->push_keys($token);

  $self->declare_key($token);

  my @keys = $self->get_keys;
  my $key  = pop @keys;
  my $node = $self->scan_to_key(\@keys);
  $node->{$key} //= [];
  push @{ $node->{$key} }, {};

  TOKEN:
  while (my $token = $self->next_token) {
    my $type = $token->{type};
    next TOKEN if $type eq 'EOL';

    if ($type eq 'key') {
      $self->expect_type($self->next_token, 'assign');
      $self->push_keys($token);
      $self->set_key($self->next_token);
      $self->pop_keys;
      next TOKEN;
    }

    if ($type eq 'array_table') {
      $self->pop_keys;
      @_ = ($self, $token);
      goto \&parse_array_table;
    }

    if ($type eq 'table') {
      $self->pop_keys;
      @_ = ($self, $token);
      goto \&parse_table;
    }

    $self->parse_error($token, "expected key-value pair, table, or array of tables but got $type");
  }
}

sub parse_key {
  my $self  = shift;
  my $token = shift // $self->next_token;
  $self->expect_type($token, 'key');
  return $token->{value};
}

sub parse_value {
  my $self  = shift;
  my $token = shift;

  my $type = $token->{type};
  return $token->{value} if $type eq 'string';
  return $self->inflate_float($token) if $type eq'float';
  return $self->inflate_integer($token) if $type eq 'integer';
  return $self->{inflate_boolean}->($token->{value}) if $type eq 'bool';
  return $self->parse_datetime($token) if $type eq 'datetime';
  return $self->parse_inline_table($token) if $type eq 'inline_table';
  return $self->parse_array($token) if $type eq 'inline_array';

  $self->parse_error($token, "value expected (bool, number, string, datetime, inline array, inline table), but found $type");
}

#-------------------------------------------------------------------------------
# TOML permits a space instead of a T, which RFC3339 does not allow. TOML (at
# least, according to BurntSushi/toml-tests) allows z instead of Z, which
# RFC3339 also does not permit. We will be flexible and allow them both, but
# fix them up. TOML also specifies millisecond precision. If fractional seconds
# are specified. Whatever.
#-------------------------------------------------------------------------------
sub parse_datetime {
  my $self  = shift;
  my $token = shift;
  my $value = $token->{value};

  # Normalize
  $value =~ tr/z/Z/;
  $value =~ tr/ /T/;
  $value =~ s/t/T/;
  $value =~ s/(\.\d+)($TimeOffset)$/sprintf(".%09d%s", $1 * 1000000000, $2)/e;

  return $self->{inflate_datetime}->($value);
}

sub parse_array {
  my $self  = shift;
  my $token = shift;

  $self->declare_key($token);

  my @array;
  my $expect = 'EOL|inline_array_close|string|float|integer|bool|datetime|inline_table|inline_array';

  TOKEN: while (1) {
    my $token = $self->next_token;
    $self->expect_type($token, $expect);

    if ( $token->{type} eq 'comma') {
      $expect = 'EOL|inline_array_close|string|float|integer|bool|datetime|inline_table|inline_array';
      next TOKEN;
    }

    next TOKEN if $token->{type} eq 'EOL';
    last TOKEN if $token->{type} eq 'inline_array_close';

    push @array, $self->parse_value($token);
    $expect = 'comma|EOL|inline_array_close';
  }

  return \@array;
}

sub parse_inline_table {
  my $self  = shift;
  my $token = shift;

  my $table  = {};
  my $expect = 'EOL|inline_table_close|key';

  TOKEN: while (1) {
    my $token = $self->next_token;
    $self->expect_type($token, $expect);

    my $type = $token->{type};
    if ($type eq 'comma') {
      $expect = $self->{strict}
        ? 'EOL|key'
        : 'EOL|key|inline_table_close';

      next TOKEN;
    }

    if ($type eq 'key') {
      $self->expect_type($self->next_token, 'assign');

      my $node = $table;
      my @keys = @{ $token->{value} };
      my $key  = pop @keys;

      for (@keys) {
        $node->{$_} ||= {};
        $node = $node->{$_};
      }

      if (exists $node->{$key}) {
        $self->parse_error($token, 'duplicate key: ' .  join('.', map{ qq{"$_"} } @{ $token->{value} }));
      } else {
        $node->{ $key } = $self->parse_value($self->next_token);
      }

      $expect = 'comma|inline_table_close';
      next TOKEN;
    }

    last TOKEN if $type eq 'inline_table_close';

    $self->parse_error($token, "inline table expected key-value pair, but found $type");
  }

  return $table;
}

sub inflate_float {
  my $self  = shift;
  my $token = shift;
  my $value = $token->{value};

  # Caller-defined inflation routine
  if ($self->{inflate_float}) {
    return $self->{inflate_float}->($value);
  }

  return 'NaN'  if $value =~ /^[-+]?nan$/i;
  return 'inf'  if $value =~ /^\+?inf$/i;
  return '-inf' if $value =~ /^-inf$/i;

  # Not a bignum
  if (0 + $value eq $value) {
    return 0 + $value;
  }

  #-----------------------------------------------------------------------------
  # Scientific notation is a hairier situation. In order to determine whether a
  # value will fit inside a perl svnv, we can't just coerce the value to a
  # number and then test it against the string, because, for example, this will
  # always be false:
  #
  #     9 eq "3e2"
  #
  # Instead, we are forced to test the coerced value against a BigFloat, which
  # is capable of holding the number.
  #-----------------------------------------------------------------------------
  if ($value =~ /[eE]/) {
    if (Math::BigFloat->new($value)->beq(0 + $value)) {
      return 0 + $value;
    }
  }

  return Math::BigFloat->new($value);
}

sub inflate_integer {
  my $self  = shift;
  my $token = shift;
  my $value = $token->{value};

  # Caller-defined inflation routine
  if ($self->{inflate_integer}) {
    return $self->{inflate_integer}->($value);
  }

  # Hex
  if ($value =~ /^0x/) {
    no warnings 'portable';
    my $hex = hex $value;
    my $big = Math::BigInt->new($value);
    return $big->beq($hex) ? $hex : $big;
  }

  # Octal
  if ($value =~ /^0o/) {
    no warnings 'portable';
    $value =~ s/^0o/0/;
    my $oct = oct $value;
    my $big = Math::BigInt->from_oct($value);
    return $big->beq($oct) ? $oct : $big;
  }

  # Binary
  if ($value =~ /^0b/) {
    no warnings 'portable';
    my $bin = oct $value; # oct handles 0b as binary
    my $big = Math::BigInt->new($value);
    return $big->beq($bin) ? $bin : $big;
  }

  # Not a bignum
  if (0 + $value eq $value) {
    return 0 + $value;
  }

  return Math::BigInt->new($value);
}

1;
