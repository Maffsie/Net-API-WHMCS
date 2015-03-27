use Moose::Util::TypeConstraints;

subtype 'LWPUserAgent' =>
	as 'Object' =>
		where { $_->isa('LWP::UserAgent') };

no Moose;
