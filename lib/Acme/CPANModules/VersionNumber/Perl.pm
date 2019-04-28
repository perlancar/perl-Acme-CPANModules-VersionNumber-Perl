package Acme::CPANModules::VersionNumber::Perl;

# DATE
# VERSION

our $LIST = {
    summary => 'Working with Perl version numbers (or version strings)',
    description => <<'_',

The core module <pm:version> (a.k.a. version.pm) should be your first go-to
module when dealing with Perl version numbers. Other modules can also help in
some aspects. Modules mentioned here include: <pm:Perl::Version>,
<pm:Versioning::Scheme::Perl>.

## Version numbers in Perl

There are two styles of version numbers used in the Perl world (i.e. for the
versioning of perl interpreter itself and for versioning Perl modules): decimal
(x.y) or dotted decimals (x.y.z or even more parts; the "v" prefix forces dotted
decimal to avoid ambiguity when there is only a single dot, e.g. v1.2).

The former variant offers simplicity since version number can mostly be
represented by a floating point number (quoting as string is still recommended
to retain all precision and trailing zeros) and comparing versions can be done
numerically. However they are often very limited so in those cases a dotted
decimal variant can be used. For example the perl interpreter itself uses x.y.z
convention.

Dotted decimal can be converted to decimal ("numified") form using this
convention: minor and lesser parts are given (at least) three decimal digits
each. For example, 1.2.3 becomes 1.002003. 1.20.3 becomes 1.020003. This can
give some surprise which has bitten Perl programmers, novice and expert alike.
In fact, it is the major gotcha when dealing with version numbers in Perl. For
example '0.02' (a decimal form) numifies to 0.02, but 'v0.02' (a dotted decimal
form) numifies to 0.002. Hence, v0.02 is less than 0.02 or even 0.01 when
compared using version->parse(). Another gotcha is when a module author decides
to go from 0.02 to 0.2.1 or 0.02.1. 0.02 (a decimal form) numifies to 0.02 while
0.2.1 or 0.02.1 (dotted decimal) numifies to 0.002001. Hence, going from 0.02 to
0.02.1 will actually *decrease* your version number. I recommend using x.yyy if
you use decimal form, i.e. start from 0.001 and not 0.01. It will support you
going smoothly to dotted decimal if you decide to do it one day.

The numification is also problematic when a number part is > 999, e.g. 1.2.1234.
This breaks version comparison when comparison is done with version->parse().

Aside from the abovementioned two styles, there is another: CPAN
distributions/modules can add an underscore in the last part of the version
number to signify alpha/dev/trial release, e.g. 1.2.3_01. PAUSE will not index
such releases, so testers will need to specify an explicit version number to
install, e.g. `cpanm Foo@1.2.3_01`. In some cases you need to pay attention when
comparing this kind of version numbers.

## Checking if a string is a valid version number

To check if a string is a valid Perl version number, you can do:

    version->parse($str)

which will die if C<$str> contains an invalid version string. version.pm can
handle the "v" prefix, (e.g. "v1.2"), dotted-decimal (e.g. "1.2.3" but also
"1.2.3.4.5"), as well as alpha/dev/trial part (e.g. "v1.1.1_001").

## Parsing a version number

version->parse, obviously enough, is used to parse a version number string into
a structure:

    use Data::Dump;
    dd( version->parse("1.2.3") );

which prints:

    bless({ original => "1.2.3", qv => 1, version => [1, 2, 3] }, "version")

However:

    dd( version->parse("1.2.3_01") );

prints:

    bless({ alpha => 1, original => "1.2.3_01", qv => 1, version => [1, 2, 301] }, "version")

## Comparing version numbers

You can compare two version numbers again using version->parse():

    version->parse($str1) <=> version->parse($str2)

For example:

    version->parse("1.2.3") <=> version->parse("v1.3.0");  # => -1

Be careful when dealing with alpha/dev/trial version:

    version->parse("1.2.3_01") <=> version->parse("v1.2.4")  ;  # => 1
    version->parse("1.2.3_01") <=> version->parse("v1.2.301");  # => 0
    version->parse("1.2.3_01") <=> version->parse("v1.2.400");  # => -1

## Normalizing a version number

To normalize a version number:

    version->parse($str)->normal

This will add a "v" prefix, force a dotted decimal form, and remove insignifcant
zeros. Examples:

    version->parse(1.2)      ->normal; # => "v1.200.0"
    version->parse("1.2.3")  ->normal; # => "v1.2.3"
    version->parse("1.2.30") ->normal; # => "v1.2.30"
    version->parse("1.2.030")->normal; # => "v1.2.30"

## Incrementing a version number

Some modules like <pm:Perl::Version> and <pm:Versioning::Scheme::Perl> can help
increase version numbers (or whichever part of the number). The last one can
also decrement parts.

_
    entries => [
        {module=>'version'},
        {module=>'Perl::Version'},
        {module=>'Versioning::Scheme::Perl'},
    ],
};

1;
# ABSTRACT:
