package Acme::CPANModules::VersionNumber::Perl;

# DATE
# VERSION

our $LIST = {
    summary => 'Working with Perl version numbers (or strings)',
    description => <<'_',

The core module <pm:version> (a.k.a. version.pm) should be your first go-to
module when dealing with Perl version numbers. To check if a string is a valid
Perl version number, you can do:

    version->parse($str)

which will die if C<$str> contains an invalid version string. version.pm can
handle the "v" prefix, (e.g. "v1.2"), multiple dot-separated parts (e.g. "1.2.3"
but also "1.2.3.4.5"), as well as alpha or dev or trial part (e.g.
"v1.1.1_001"). You can also compare two version numbers using:

    version->parse($str1) <=> version->parse($str2)

or normalize a version number using:

    version->parse($str)->normal

A peculiarity of version numbers used in Perl lang is that two styles are used:
pure decimal number (1.002003) or dotted-decimal parts (1.2.3; the v prefix
forces dotted-decimal to avoid ambiguity when there is only a single dot, e.g.
v1.2). Sometimes (for historical reason and/or ease of comparison) a
dotted-decimal is converted to pure decimal (a process called numifying). This
has some surprises and consequences which has bitten Perl programmers, novice
and expert alike (e.g. '0.01' numifies to 0.010 but 'v0.01' numifies to 0.001).

To numify version:

    version->parse('v1.2')->numify; # => 1.002000
    version->parse('1.2') ->numify; # => 1.200

Going the other way is not as straightforward:

    version->parse('1.002003')->stringify; # => 1.002003

Aside from version.pm, some other modules mentioned below can be handy when
dealing with Perl-style version strings.

<pm:Perl::Version>, and <pm:Versioning::Scheme::Perl> can increase version
numbers (or whichever part of the number). The last one can also decrement
parts.

_
    entries => [
        {module=>'version'},
        {module=>'Perl::Version'},
        {module=>'Versioning::Scheme::Perl'},
    ],
};

1;
# ABSTRACT:
