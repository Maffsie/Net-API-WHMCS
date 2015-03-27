#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Net::API::WHMCS' ) || print "Bail out!\n";
}

diag( "Testing Net::API::WHMCS $Net::API::WHMCS::VERSION, Perl $], $^X" );
