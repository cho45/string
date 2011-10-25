
use Test::More;
use Test::Fatal;
use Test::Name::FromLine;

subtest no_string => sub {
	ok !string::is_string("ああ");
	ok !string::is_string("aa");

	ok string::is_bytearray("ああ");
	ok string::is_bytearray("aa");

	is string::dump("ああ"), 'ああ';
};

subtest use_string => sub {
	use string;

	ok string::is_string("ああ");
	ok string::is_string("aa");

	ok !string::is_bytearray("ああ");
	ok !string::is_bytearray("aa");

	ok string::is_bytearray(encode_utf8 "ああ");
	ok string::is_bytearray(encode_utf8 "aa");

	is string::dump("ああ"), 'string (ああ)';

	my $str = "aa";
	is string::ensure($str), $str;

	my $bytes  = encode_utf8 "ああ";
	my $string = decode_utf8 "ああ";

	is   exception { string::ensure($string) }, undef;
	like exception { string::ensure($bytes) }, qr'argument is not a string';

	like exception { $bytes . $string }, qr'Bytes implicitly upgraded into wide characters';
};

done_testing;
