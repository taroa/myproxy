# myproxy
AnyEvent simple HTTP proxy

usage: plackup -s [Twiggy or Twiggy::Prefork] myproxy.pl --no-default-middleware

only work on AnyEvent based handler (Twiggy), other handlers will not work properly.
