package TOML::Tiny::Tokenizer;
# ABSTRACT: tokenizer used by TOML::Tiny

use strict;
use warnings;
no warnings qw(experimental);
use charnames qw(:full);
use v5.18;

use TOML::Tiny::Grammar;

sub new {
  my ($class, %param) = @_;

  my $self = bless{
    source        => $param{source},
    last_position => length $param{source},
    position      => 0,
    line          => 1,
    last_token    => undef,
  }, $class;

  return $self;
}

sub next_token {
  my $self = shift;

  return unless defined $self->{source}
      && $self->{position} < $self->{last_position};

  if (!$self->{last_token}) {
    return $self->{last_token} = {type => 'table', pos => 0, line => 1, value => []};
  }

  # Update the regex engine's position marker in case some other regex
  # attempted to match against the source string and reset it.
  pos($self->{source}) = $self->{position};

  my $token;
  my $type;
  my $value;

  state $key_set     = qr/\G ($Key) $WS* (?= =)/x;
  state $table       = qr/\G \[ $WS* ($Key) $WS* \] $WS* (?:$EOL | $)/x;
  state $array_table = qr/\G \[\[ $WS* ($Key) $WS* \]\] $WS* (?:$EOL | $)/x;

  state $simple = {
    '['     => 'inline_array',
    ']'     => 'inline_array_close',
    '{'     => 'inline_table',
    '}'     => 'inline_table_close',
    ','     => 'comma',
    '='     => 'assign',
    'true'  => 'bool',
    'false' => 'bool',
  };

  # More complex matches with regexps
  while ($self->{position} < $self->{last_position} && !defined($type)) {
    my $prev = $self->{last_token} ? $self->{last_token}{type} : 'EOL';
    my $newline = !!($prev eq 'EOL' || $prev eq 'table' || $prev eq 'array_table');

    for ($self->{source}) {
      /\G$WS+/gc;               # ignore whitespace
      /\G$Comment$/mgc && next;  # ignore comments

      last when /\G$/gc;

      when (/\G$EOL/gc) {
        ++$self->{line};
        $type = 'EOL';
      }

      if ($newline) {
        when (/$table/gc) {
          $type = 'table';
          $value = $self->tokenize_key($1);
        }

        when (/$array_table/gc) {
          $type = 'array_table';
          $value = $self->tokenize_key($1);
        }
      }

      when (/\G ( [\[\]{}=,] | true | false )/xgc) {
        $value = $1;
        $type = $simple->{$value};
      }

      when (/$key_set/gc) {
        $type = 'key';
        $value = $1;
      }

      when (/\G($String)/gc) {
        $type = 'string';
        $value = $1;
      }

      when (/\G($DateTime)/gc) {
        $type = 'datetime';
        $value = $1;
      }

      when (/\G($Float)/gc) {
        $type = 'float';
        $value = $1;
      }

      when (/\G($Integer)/gc) {
        $type = 'integer';
        $value = $1;
      }

      default{
        my $substr = substr($self->{source}, $self->{position}, 30) // 'undef';
        die "toml syntax error on line $self->{line}\n\t-->|$substr|\n";
      }
    }

    if ($type) {
      state $tokenizers = {};
      my $tokenize = $tokenizers->{$type} //= $self->can("tokenize_$type") || 0;

      $token = $self->{last_token} = {
        line  => $self->{line},
        pos   => $self->{pos},
        type  => $type,
        value => $tokenize ? $tokenize->($self, $value) : $value,
      };
    }

    $self->update_position;
  }

  return $token;
}

sub current_line {
  my $self = shift;
  my $rest = substr $self->{source}, $self->{position};
  my $stop = index $rest, "\n";
  substr $rest, 0, $stop;
}

sub update_position {
  my $self = shift;
  $self->{position} = pos($self->{source}) // 0;
}

sub error {
  my $self  = shift;
  my $token = shift;
  my $msg   = shift // 'unknown';
  my $line  = $token ? $token->{line} : $self->{line};
  die "toml: parse error at line $line: $msg\n";
}

sub tokenize_key {
  my $self = shift;
  my $toml = shift;
  my @keys = $toml =~ /($SimpleKey)\.?/g;

  for (@keys) {
    s/^["']//;
    s/["']$//;
  }

  return \@keys;
}

sub tokenize_float {
  $_[1] =~ tr/_//d;
  $_[1];
}

sub tokenize_integer {
  $_[1] =~ tr/_+//d;
  $_[1] !~ m/^0[xob]/ && $_[1] + 0 eq $_[0] ? $_[1] + 0 : "$_[1]"
}

sub tokenize_string {
  my $self = shift;
  my $toml = shift;
  my $ml   = index($toml, q{'''}) == 0
          || index($toml, q{"""}) == 0;
  my $lit  = index($toml, q{'}) == 0;
  my $str  = '';

  if ($ml) {
    $str = substr $toml, 3, length($toml) - 6;
    my @newlines = $str =~ /($CRLF)/g;
    $self->{line} += scalar @newlines;
    $str =~ s/^$WS* $EOL//x;  # trim leading whitespace
    $str =~ s/\\$EOL\s*//xgs; # trim newlines from lines ending in backslash
  } else {
    $str = substr($toml, 1, length($toml) - 2);
  }

  if (!$lit) {
    $str = $self->unescape_str($str);
  }

  return $str;
}

sub unescape_chars {
  state $esc = {
    '\b'   => "\x08",
    '\t'   => "\x09",
    '\n'   => "\x0A",
    '\f'   => "\x0C",
    '\r'   => "\x0D",
    '\"'   => "\x22",
    '\/'   => "\x2F",
    '\\\\' => "\x5C",
  };

  if (exists $esc->{$_[0]}) {
    return $esc->{$_[0]};
  }

  my $hex = hex substr($_[0], 2);

  if (charnames::viacode($hex)) {
    return chr $hex;
  }

  return;
}

sub unescape_str {
  state $re = qr/($Escape)/;
  $_[1] =~ s|$re|unescape_chars($1) // $_[0]->error(undef, "invalid unicode escape: $1")|xge;
  $_[1];
}

1;
