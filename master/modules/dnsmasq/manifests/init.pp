# == Class: dnsmasq
#
# Sets up and configures the lightweight DNSMasq server.
#
# === Parameters
#
# $upstream_nameservers, the upstream nameservers to use for forwarding queries
# default: ['8.8.8.8', '8.8.4.4'] which are the Google public DNS servers.
# You could also use the OpenDNS servers: ['208.67.222.222', '208.67.220.220']
#
# === Example
#
#  class { dnsmasq:
#    upstream_nameservers => ['208.67.222.222', '208.67.220.220'],
#  }
#
class dnsmasq (
  $upstream_nameservers = ['8.8.8.8', '8.8.4.4'],
){
  package { 'dnsmasq':
    ensure  => installed,
  }

  augeas { 'dnsmasq conf-dir':
    context => '/files/etc/dnsmasq.conf',
    changes => 'set conf-dir /etc/dnsmasq.d',
    require => Package['dnsmasq'],
  }

  include dnsmasq::collect
}
