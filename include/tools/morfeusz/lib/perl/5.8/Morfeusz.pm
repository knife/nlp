package Morfeusz;

use 5.006;
use strict;
use warnings;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Morfeusz ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	morfeusz_about
	morfeusz_analyse
	morfeusz_set_options
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.4';

bootstrap Morfeusz $VERSION;

# Preloaded methods go here.

sub morfeusz_set_options {
    my $retval =1;
    for my $i (split /\s*,\s*/, shift) {
	die "Wrong options string '$i'"
	    unless $i =~ m/^([a-z]+)\s*=\s*([A-Za-z0-9_-]+)$/;
	my ($opt, $val) = ($1,$2);
	if ($opt eq 'encoding') {
	    if ($val eq 'ISO8859-2' || $val eq 'ISO8859_2' ||
		$val eq 'LATIN-2') {
		$retval = 0 unless morfeusz_set_option_internal(1,88592);
	    } elsif ($val eq 'CP1250') {
		$retval = 0 unless morfeusz_set_option_internal(1,1250);
	    } elsif ($val eq 'CP852') {
		$retval = 0 unless morfeusz_set_option_internal(1,852);
	    } elsif ($val eq 'UTF-8' || $val eq 'UTF8') {
		$retval = 0 unless morfeusz_set_option_internal(1,8);
	    } else {
		die "Wrong encoding name '$val'";
	    }
	} else {
	    die "Wrong option '$opt'";
	}
    }
    return $retval;
}

1;
__END__
