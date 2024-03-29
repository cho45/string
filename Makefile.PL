BEGIN {
	my @mip = qw(
		Module::Install::AuthorTests
		Module::Install::Repository
		Module::Install::ReadmeFromPod
	);
	for (@mip) {
		eval "require $_";
		if ($@) {
			eval "require inc::$_";
			if ($@) {
				warn $@;
				printf("# Install following (perl Makefile.PL | cpanm):\n%s", join("\n", @mip));
				exit 1;
			}
		}
	}
};

use inc::Module::Install;
name 'string';
all_from 'lib/string.pm';

requires 'Exporter::Lite';

build_requires 'Test::More';

# Module::Install::AuthorTests
author_tests('xt');

# Module::Install::Repository
auto_set_repository;

# Module::Install::ReadmeFromPod
readme_from 'lib/string.pm';

auto_include;
WriteAll;
