#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;

use Net::API::WHMCS;
use Data::Dumper;

my $whmcs = Net::API::WHMCS->new(
	user => '',
	password => '',
	api_token => '',
	endpoint => '',
	secure => 1);
say "Initialisation failed" unless ref $whmcs eq 'Net::API::WHMCS';
my $method = shift or die 'no arg';
my %args = (); my $curarg = "";
for (@ARGV) { $curarg = $1 and next if /^--(.*)$/; $args{$curarg} .= ' ' if length $args{$curarg}; $args{$curarg} .= $_; }
# usage: ./test_interface.pl getticket --ticketid 1234
say Dumper($whmcs->api_request($method,%args));
