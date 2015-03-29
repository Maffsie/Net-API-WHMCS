package Net::API::WHMCS::Ticket::Note;

use Moose;

has 'id'      => ( is => 'ro', isa => 'Int', required => 1 );
has 'user'    => ( is => 'ro', isa => 'Str', required => 1 );
has 'date'    => ( is => 'ro', isa => 'DateTime', required => 1 );
has 'content' => ( is => 'ro', isa => 'Str', required => 1 );

no Moose;
1;
__END__
