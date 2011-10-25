package string;

use strict;
use warnings;
use utf8;
use Encode;
use Carp;

our $VERSION = '0.01';
our @EXPORT = qw(
	encode
	encode_utf8
	decode
	decode_utf8
);

*encode = \&encode;
*encode_utf8 = \&encode_utf8;
*decode = \&decode;
*decode_utf8 = \&decode_utf8;

sub import {
	require encoding::warnings;
	encoding::warnings->import('FATAL');

	require utf8;
	utf8->import;

	require Exporter::Lite;
	goto &Exporter::Lite::import;
}

sub unimport {
	encoding::warnings->unimport;
	utf8->unimport;
}

# contract string
sub ensure {
	is_string($_[0]) or croak "argument is not a string";
	$_[0];
}

# is string
sub is_string ($) {
	utf8::is_utf8($_[0]);
}

# is byte array
sub is_bytearray ($) {
	!utf8::is_utf8($_[0]);
}

# return string dump encoded as utf-8;
sub dump {
	is_string($_[0]) ? decode_utf8 "string ($_[0])" : $_[0];
}

1;
__END__

=encoding utf8

=head1 NAME

string - explicit string definition

=head1 SYNOPSIS

  use string;

  ok string::is_string("ああ");
  ok string::is_string("aa");

  ok !string::is_bytearray("ああ");
  ok !string::is_bytearray("aa");

  ok string::is_bytearray(encode_utf8 "ああ");
  ok string::is_bytearray(encode_utf8 "aa");

  # croak if the $str is not string (this is for definition of requiring string)
  # and return argument as-is.
  $str = string::ensure($str);

  $bytes . $string; # exception with encoding::warnings

=head1 DESCRIPTION

string is for safety string programming.

string pragma define utf8 flagged string as 'string'.
Perl treats non flagged string (eg. string only consisting of ASCII) sometimes, so the distinction of string and bytes is only in a programmer.
Other programmers must read between the lines, this is bad.

This pragma provides explicit string definition. In this case, all of string must be flagged, and all programmers distinguish string or bytes.

And more, Perl should not make someone aware of internal encoding (utf8). It should be just called with string.

=head1 AUTHOR

cho45 E<lt>cho45@lowreal.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
