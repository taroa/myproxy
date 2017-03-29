use Plack::Builder;
use Data::Dumper;
use AnyEvent;
use AnyEvent::HTTP;

my $cookie_jar = {};
my $app = sub{
    my $env = shift;
    print Dumper $env;
    sub{
        my $responder = shift;
        my $method = $env->{REQUEST_METHOD};
        my $url = $env->{REQUEST_URI};
        my $accept_encoding = $env->{HTTP_ACCEPT_ENCODING};
        my $accept = $env->{HTTP_ACCEPT};
        my $accept_language = $env->{HTTP_ACCEPT_LANGUAGE};
        my $connection = $env->{HTTP_CONNECTION};
        my $useragent = $env->{HTTP_USER_AGENT};
        my $cookie = $env->{HTTP_COOKIE};
#        warn ">>server connect to remote...\n";
        my $w;$w = http_request $method => $url, cookie_jar => $cookie_jar, recurse => 0,
        headers => {Accept=>$accept, "Accept-Encoding"=>$accept_encoding,"Accept-Language"=>$accept_language,Connection=>$connection,"User-Agent"=>$useragemt} ,
        sub{
            undef $w;
#            print Dumper $_[1];
            my ($content,$headers) = @_;
            $responder->([$headers->{Status},[ map{ref $_ eq "ARRAY" ? join ", ",@{$_}  : $_; } %{$headers} ],[$content]]);
        };
    }
};

builder {
    enable "Proxy::Connect";
    $app;
};
