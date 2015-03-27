package Net::API::WHMCS::Ticket;

use Net::API::WHMCS::Types;

use Moose;

# 'id' is the internal ticket ID number, 'public_id' is the ticket ID presented to the client
has 'id' => (
	is				=> 'ro',
	isa				=> 'Int',
	required	=> 1,
);
has 'public_id' => (
	is				=> 'ro',
	isa				=> 'Str',
	required	=> 1,
);
has 'subject' => (
	is				=> 'ro',
	isa				=> 'Str',
	required	=> 1,
);
has 'status' => (
	is				=> 'rw',
	isa				=> 'Str',
	required	=> 1,
);
# tickets can pertain to unregistered clients, so this isn't required.
has 'client' => (
	is				=> 'ro',
	isa				=> 'WHMCSClient',
	required	=> 0,
	predicate	=> 'has_client',
);
#TODO: Add the following attributes:
# - Tags (not required)
# - Assigned admin (not required, predicate is_flagged)
# - Category
# - Priority (rw, isa WHMCSTicketPriority)
# - Date
# - Service (not required, predicate has_related_service, isa WHMCSService)

#TODO: Implement the following methods:
# - Reply to ticket
# - Close ticket
# - Change ticket status
# - Flag to admin
# - Add ticket note

#Other thoughts:
# - It would be nice if the assigned admin attribute could look up the actual name of the flagged admin, but to my knowledge the WHMCS API does not expose any methods that would allow you to fetch an admin name by their ID. I'd contemplate coming up with a quick WHMCS module to achieve this, but to my knowledge the WHMCS API is not extensible. An alternative would be to allow the user to supply a list of admin ID->name mappings, but eh.
# - Ticket replies and notes might be better off being contained in their own class? ::WHMCS::Ticket could have attribute 'replies' which isa Array[WHMCSTicketReply] and attribute 'notes' which isa Array[WHMCSTicketNote], both being objects, such that they're created as ::WHMCS::Ticket::Reply and ::WHMCS::Ticket::Note.
# - ::WHMCS::Ticket::Reply could have methods edit() and delete(), as WHMCS allows ticket replies to be edited and deleted.
# - ::WHMCS::Ticket::Note could have the method delete(), as notes are not editable.

no Moose;
1;
__END__
