package Net::API::WHMCS::Ticket;

use Moose;
use Net::API::WHMCS::Types;

has 'id'              => ( is => 'ro', isa => 'Int', required => 1 );
has 'public_id'       => ( is => 'ro', isa => 'Str', required => 1 );
has 'category'        => ( is => 'ro', isa => 'Str', required => 1 );
has 'priority'        => ( is => 'ro', isa => 'WHMCSTicketPriority',
                                                     required => 1 );
has 'subject'         => ( is => 'ro', isa => 'Str', required => 1 );
has 'client'          => ( is => 'ro', isa => 'WHMCSClient',
                          predicate => 'has_client', required => 0 );
has 'status'          => ( is => 'rw', isa => 'Str', required => 1 );
has 'tags'            => ( is => 'ro', isa => 'ArrayRef[Str]',
                           predicate => 'is_tagged', required => 0 );
has 'assigned_admin'  => ( is => 'rw', isa => 'Int',
                         predicate => 'is_assigned', required => 0 );
has 'replies'         => ( is => 'rw', isa => 'ArrayRef[WHMCSTicketReply]',
                                                     required => 1 );
has 'notes'           => ( is => 'rw', isa => 'ArrayRef[WHMCSTicketNote]',
                                                     required => 1 );
has 'related_service' => ( is => 'ro', isa => 'WHMCSService',
                 predicate => 'has_related_service', required => 0 );

sub add_note {
}
sub add_reply {
}
sub assign {
}
sub close {
}

no Moose;
1;
__END__
