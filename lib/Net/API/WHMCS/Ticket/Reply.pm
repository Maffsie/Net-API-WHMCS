package Net::API::WHMCS::Ticket::Reply;

use Moose;

has 'admin'       => ( is => 'ro', isa => 'Str',
                   predicate => 'sent_by_admin', required => 0 );
has 'userid'      => ( is => 'ro', isa => 'Int', required => 0 );
has 'contactid'   => ( is => 'ro', isa => 'Int', required => 0 );
has 'email'       => ( is => 'ro', isa => 'Str', required => 0 );
has 'name'        => ( is => 'ro', isa => 'Str', required => 1 );
has 'date'        => ( is => 'ro', isa => 'DateTime',
                                                 required => 1 );
has 'message'     => ( is => 'ro', isa => 'Str', required => 1 );
has 'attachment'  => ( is => 'ro', isa => 'Str',
                predicate => 'is_file_attached', required => 0 );

no Moose;
1;
__END__
