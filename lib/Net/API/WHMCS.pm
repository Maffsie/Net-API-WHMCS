package Net::API::WHMCS;

use Net::API::WHMCS::Types;

use Moose;
use Carp qw/carp croak/;

use LWP::UserAgent;

use Digest::MD5			qw/md5_hex/;
use HTML::Entities	qw/decode_entities/;
use JSON::PP				qw/decode_json/;

our $VERSION = '0.13';

has ['endpoint', 'user', 'password'] => (
	is				=> 'ro',
	isa				=> 'Str',
	required	=> 1,
);
has 'api_token' => (
	is				=> 'ro',
	isa				=> 'Str',
	predicate	=> 'has_token',
);
has '+endpoint' => (
	writer		=> '_set_endpoint',
	trigger		=> sub {
		my ($self,$endpoint,$previous) = @_;
		return if defined $previous;
		$self->_set_endpoint("$endpoint/includes/api.php");
	},
);
has '+password' => (
	writer		=> '_set_pass',
	trigger		=> sub {
		my ($self,$pass,$previous) = @_;
		return if defined $previous;
		$self->_set_pass(md5_hex($pass));
	},
);
has 'secure' => (
	is				=> 'ro',
	isa				=> 'Int',
	default		=> 1,
	predicate	=> 'is_secure',
);
has 'wwwclient' => (
	is				=> 'ro',
	isa				=> 'LWPUserAgent',
	default		=> sub { return LWP::UserAgent->new(agent => "Net::API::WHMCS/$VERSION") },
);
has 'support_departments' => (
	is				=> 'ro',
	isa				=> 'HashRef',
	lazy_build=> 1,
	builder		=> '_build_support_departments',
);

#Upon creation, check that we're able to access the WHMCS installation specified.
#This is done because if we're unable to call 'getadmindetails', then we won't be able to call /anything/.
sub BUILD {
	my ($self,$opts) = @_;
	require LWP::Protocol::https or croak "SSL enabled, but LWP::Protocol::https is unavailable" if $self->is_secure;
	my $test = $self->api_request('getadmindetails') or croak "Could not connect to API!".($self->has_token? '' : ' No API token was supplied; one may be required.');
	croak "Could not confirm API connection successful via 'getadmindetails'!" unless $test->{result} eq 'success';
}

sub api_request {
	my $self = shift;
	my $method = shift;
	my $request = $self->_build_request(action => $method,@_) or return undef;
	my $result = $self->_parse_request($request) or return undef;
	return $result;
}

sub _build_support_departments {
	my $self = shift;
	my $result = $self->api_request('getsupportdepartments',ignore_dept_assignments => 1);
	return undef unless $result->{result} eq 'success';
	my %departments = map { $_->{id}, $_->{name} } @{$result->{departments}->{department}};
	return \%departments;
}

sub _build_request {
	my $self = shift;
	my %fields = (
		'username'			=> $self->user,
		'password'			=> $self->password,
		'responsetype'	=> 'json',
		@_,
	);
	$fields{accesskey} = $self->api_token if $self->has_token;
	return $self->wwwclient->post($self->endpoint,\%fields) or return undef;
}

sub _parse_request {
	my ($self,$request) = @_;
	my $response = decode_entities($request->decoded_content);
	$response =~ /^{/ or return undef;
	return decode_json $response or return undef;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
__END__
