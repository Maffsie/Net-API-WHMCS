use Moose::Util::TypeConstraints;

class_type 'LWPUserAgent',      { class => 'LWP::UserAgent'                 };

class_type 'WHMCSClient',       { class => 'Net::API::WHMCS::Client'        };
class_type 'WHMCSService',      { class => 'Net::API::WHMCS::Service'       };
class_type 'WHMCSTicket',       { class => 'Net::API::WHMCS::Ticket'        };
class_type 'WHMCSTicketNote',   { class => 'Net::API::WHMCS::Ticket::Note'  };
class_type 'WHMCSTicketReply',  { class => 'Net::API::WHMCS::Ticket::Reply' };

enum       'WHMCSTicketPriority', [qw/Low Medium High/];

no Moose::Util::TypeConstraints;
1;
__END__
