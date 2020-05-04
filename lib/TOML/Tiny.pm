package TOML::Tiny;
# ABSTRACT: a minimal, pure perl TOML parser and serializer

use strict;
use warnings;
no warnings qw(experimental);
use v5.18;

use TOML::Tiny::Parser;
use TOML::Tiny::Writer;

use parent 'Exporter';

our @EXPORT = qw(
  from_toml
  to_toml
);

#-------------------------------------------------------------------------------
# TOML module compatibility
#-------------------------------------------------------------------------------
sub from_toml {
  my $source = shift;
  my $parser = TOML::Tiny::Parser->new(@_);
  my $toml = eval{ $parser->parse($source) };
  if (wantarray) {
    return ($toml, $@);
  } else {
    die $@ if $@;
    return $toml;
  }
}

sub to_toml {
  goto \&TOML::Tiny::Writer::to_toml;
}

#-------------------------------------------------------------------------------
# Object API
#-------------------------------------------------------------------------------
sub new {
  my ($class, %param) = @_;
  bless{ %param, parser => TOML::Tiny::Parser->new(%param) }, $class;
}

sub decode {
  my ($self, $source) = @_;
  $self->{parser}->parse($source);
}

sub encode {
  my ($self, $data) = @_;
  TOML::Tiny::Writer::to_toml($data,
    strict_arrays => $self->{strict_arrays},
    datetime_formatter => $self->{datetime_formatter},
    no_string_guessing => $self->{no_string_guessing},
  );
}

#-------------------------------------------------------------------------------
# For compatibility with TOML::from_toml's use of $TOML::Parser
#-------------------------------------------------------------------------------
sub parse {
  goto \&decode;
}

1;

=head1 SYNOPSIS

  use TOML::Tiny qw(from_toml to_toml);

  binmode STDIN,  ':encoding(UTF-8)';
  binmode STDOUT, ':encoding(UTF-8)';

  # Decoding TOML
  my $toml = do{ local $/; <STDIN> };
  my ($parsed, $error) = from_toml $toml;

  # Encoding TOML
  say to_toml({
    stuff => {
      about => ['other', 'stuff'],
    },
  });

  # Object API
  my $parser = TOML::Tiny->new;
  my $data = $parser->decode($toml);
  say $parser->encode($data);


=head1 DESCRIPTION

C<TOML::Tiny> implements a pure-perl parser and generator for the
L<TOML|https://github.com/toml-lang/toml> data format. It conforms to TOML v5
(with a few caveats; see L</strict_arrays>) with support for more recent
changes in pursuit of v6.

C<TOML::Tiny> strives to maintain an interface compatible to the L<TOML> and
L<TOML::Parser> modules, and could even be used to override C<$TOML::Parser>:

  use TOML;
  use TOML::Tiny;

  local $TOML::Parser = TOML::Tiny->new(...);
  say to_toml(...);


=head1 EXPORTS

C<TOML::Tiny> exports the following to functions for compatibility with the
L<TOML> module. See L<TOML/FUNCTIONS>.

=head2 from_toml

Parses a string of C<TOML>-formatted source and returns the resulting data
structure. Any arguments after the first are passed to L<TOML::Tiny::Parser>'s
constructor.

If there is a syntax error in the C<TOML> source, C<from_toml> will die with
an explanation which includes the line number of the error.

  my $result = eval{ from_toml($toml_string) };

Alternately, this routine may be called in list context, in which case syntax
errors will result in returning two values, C<undef> and an error message.

  my ($result, $error) = from_toml($toml_string);

Homogenous array strictures are enabled by passing C<strict_arrays>:

  # Croaks
  my $result = from_toml(q{mixed=[1, 2, "three"]})

Additional arguments may be passed after the toml source string; see L</new>.

=head2 to_toml

Encodes a hash ref as a C<TOML>-formatted string.

  my $toml = to_toml({foo => {'bar' => 'bat'}});

  # [foo]
  # bar="bat"

Homogenous array strictures are enabled by passing C<strict_arrays>:

  # Croaks
  my $toml = to_toml({mixed => [1, 2, "three"]}, strict_arrays => 1);

=head1 OBJECT API

=head2 new

=over

=item inflate_datetime

By default, C<TOML::Tiny> treats TOML datetimes as strings in the generated
data structure. The C<inflate_datetime> parameter allows the caller to provide
a routine to intercept those as they are generated:

  use DateTime::Format::RFC3339;

  my $parser = TOML::Tiny->new(
    inflate_datetime => sub{
      my $dt_string = shift;
      return DateTime::Format::RFC3339->parse_datetime($dt_string);
    },
  );

=item inflate_boolean

By default, boolean values in a C<TOML> document result in a C<1> or C<0>.
If L<Types::Serialiser> is installed, they will instead be C<Types::Serialiser::true>
or C<Types::Serialiser::false>.

If you wish to override this, you can provide your own routine to generate values:

  my $parser = TOML::Tiny->new(
    inflate_boolean => sub{
      my $bool = shift;
      if ($bool eq 'true') {
        return 'The Truth';
      } else {
        return 'A Lie';
      }
    },
  );

=item inflate_integer

TOML integers are 64 bit and may not match the size of the compiled perl's
internal integer type. By default, integers other than smallish
decimal integers are left as-is as perl strings which may be upgraded
as needed by the caller.

  my $parser = TOML::Tiny->new(
    inflate_integer => sub{
      use bignum;
      return 0 + shift;
    }
  );

=item inflate_float

TOML floats are 64 bit and may not match the size of the compiled perl's
internal float type. By default, integers are left as-is as perl strings which
may be upgraded as needed by the caller.

  my $parser = TOML::Tiny->new(
    inflate_float => sub{
      use bignum;
      return 0 + shift;
    }
  );

=item strict_arrays

C<TOML v5> specified homogenous arrays. This has since been removed and will no
longer be part of the standard as of C<v6> (as of the time of writing; the
author of C<TOML> has gone back and forth on the issue, so no guarantees).

By default, C<TOML::Tiny> is flexible and supports heterogenous arrays. If you
wish to require strictly typed arrays (for C<TOML>'s definition of "type",
anyway), C<strict_arrays> will produce an error when encountering arrays with
heterogenous types.

=item no_string_guessing

When encoding a Perl scalar it is not always clear what the TOML type
of the value is supposed to be.  By default, C<TOML::Tiny> will, for
unblessed scalars, guess based on the scalar's appearance.  Strings
that look like numbers, or like datetimes, will be encoded as such.

With no_string_guessing, C<TOML::Tiny> will look at the perl innards
to find the currently stored value type.  If it is a number, the
scalar will be encoded as a number.  If it's a string, as a string.
Dates and times which weren't built with DateTime come out as strings.

Specifying C<inflate_float>, C<inflate_integer>, and
C<inflate_datetime> is likely to be helpful with this option.

=item datetime_formatter

When encoding a DateTime object, by default C<TOML::Tiny> will use the
default formatter.  This is not right for TOML which requires RFC3339.
If you have C<DateTime::Format::RFC3339> available, use this instead:

  my $parser = TOML::Tiny->new(
    datetime_formatter => DateTime::Format::RFC3339->new(),
  );

=back

=head2 decode

Decodes C<TOML> and returns a hash ref. Dies on parse error.

=head2 encode

Encodes a perl hash ref as a C<TOML>-formatted string. Dies when encountering
an array of mixed types if C<strict_arrays> was set.

=head2 parse

Alias for C<decode> to provide compatibility with C<TOML::Parser> when
overriding the parser by setting C<$TOML::Parser>.


=head1 DIFFERENCES FROM L<TOML> AND L<TOML::Parser>

C<TOML::Tiny> differs in a few significant ways from the L<TOML> module,
particularly in adding support for newer C<TOML> features and strictness.

L<TOML> defaults to lax parsing and provides C<strict_mode> to (slightly)
tighten things up. C<TOML::Tiny> defaults to (somehwat) stricter parsing, with
the exception of permitting heterogenous arrays (illegal in v4 and v5, but
permissible in the upcoming v6); optional enforcement of homogenous arrays is
supported with C<strict_arrays>.

C<TOML::Tiny> supports a number of options which do not exist in L<TOML>:
L</inflate_integer>, L</inflate_float>, and L</strict_arrays>.

C<TOML::Tiny> ignores invalid surrogate pairs within basic and multiline
strings (L<TOML> may attempt to decode an invalid pair). Additionally, only
those character escapes officially supported by TOML are interpreted as such by
C<TOML::Tiny>.

C<TOML::Tiny> supports stripping initial whitespace and handles lines
terminating with a backslash correctly in multilne strings:

  # TOML input
  x="""
  foo"""

  y="""\
     how now \
       brown \
  bureaucrat.\
  """

  # Perl output
  {x => 'foo', y => 'how now brown bureaucrat.'}

C<TOML::Tiny> includes support for integers specified in binary, octal or hex
as well as the special float values C<inf> and C<nan>.

=head1 SEE ALSO

=over

=item L<TOML::Tiny::Grammar>

Regexp scraps used by C<TOML::Tiny> to parse TOML source.

=back

=head1 ACKNOWLEDGEMENTS

Thanks to L<ZipRecruiter|https://www.ziprecruiter.com> for encouraging their
employees to contribute back to the open source ecosystem. Without their
dedication to quality software development this distribution would not exist.
