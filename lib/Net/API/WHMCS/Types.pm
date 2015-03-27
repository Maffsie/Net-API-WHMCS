use Moose::Util::TypeConstraints;

subtype 'LWPUserAgent' =>
	as 'Object' =>
		where { $_->isa('LWP::UserAgent') };

subtype 'WHMCSClient' =>
	as 'Object' =>
		where { $_->isa('Net::API::WHMCS::Client') };

enum 'WHMCSTicketPriority', [qw/Low Medium High/];

no Moose;
