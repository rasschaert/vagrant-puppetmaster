# Class: dns
#
#

# Class: dns::server
# Generic DNS server class
# I've chose DNSmasq because it is lightweight and easy to configure
class dns::server {
  include dnsmasq
}


# Class: dns::client
# Set the resolv.conf and point it to the DNS server
class dns::client {
  # resources
}

# Class: dns::entry
# Export a hosts line so it can be collected by DNSmasq
class dns::entry {
  @@concat::fragment {"$::hostname":
    target  => "/etc/dnsmasq.d/${::domain}.conf",
    content => "1.2.3.4 ${::hostname}",
    tag     => 'dns-entry',
  }
}
