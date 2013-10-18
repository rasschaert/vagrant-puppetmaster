# Class: dns::client
# Set the resolv.conf and point it to the DNS server
class dns::client {
  file { '/etc/resolv.conf':
    ensure  => file,
    content => "search ${::domain}\nnameserver 192.168.100.10\n"
  }
}
