# Class: dns::server
# Generic DNS server class
# Dnsmasq because it is lightweight and easy to configure
class dns::server {
  include dnsmasq
}

# Class: dns::client
# Set the resolv.conf and point it to the DNS server
class dns::client {
  file { '/etc/resolv.conf':
    ensure  => file,
    content => "search ${::domain}\nnameserver 192.168.100.10\n"
  }
}

# Class: dns::entry
# Export a hosts line so it can be collected by DNSmasq
class dns::entry {
  @@concat::fragment {$::fqdn:
    # target  => "/etc/dnsmasq.d/${::domain}.conf",
    target  => '/etc/hosts.dnsmasq',
    content => "${::ipaddress_eth1}\t${::fqdn}\n",
    tag     => 'dns-entry',
  }
}
