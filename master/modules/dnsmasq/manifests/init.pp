# == Class: dnsmasq
#
# Sets up and configures the lightweight Dnsmasq server.
#
# === Parameters
#
# $forward_nameservers, the forward nameservers to use for forwarding queries
# default: ['8.8.8.8', '8.8.4.4'] which are the Google public DNS servers.
# You could also use the OpenDNS servers: ['208.67.222.222', '208.67.220.220']
#
# === Example
#
#  class { dnsmasq:
#    forward_nameservers => ['208.67.222.222', '208.67.220.220'],
#  }
#
class dnsmasq (
  $forward_nameservers = ['8.8.8.8', '8.8.4.4'],
){
  package { 'dnsmasq':
    ensure  => installed,
  }

  augeas { 'dnsmasq conf-dir':
    context => '/files/etc/dnsmasq.conf',
    changes => 'set conf-dir /etc/dnsmasq.d',
    require => Package['dnsmasq'],
  }

  file { "/etc/dnsmasq.d/${::domain}.conf":
    ensure  => file,
    require => Package['dnsmasq'],
    content =>
      "resolv-file=/etc/resolv.dnsmasq\naddn-hosts=/etc/hosts.dnsmasq\n",
    notify  => Service['dnsmasq'],
  }

  file { '/etc/resolv.dnsmasq':
    ensure  => file,
    content => template("${module_name}/resolv.dnsmasq.erb"),
    notify  => Service['dnsmasq'],
  }

  include dnsmasq::collect

  service { 'dnsmasq':
    enable => true,
    ensure => running,
    require => Class['dnsmasq::collect'],
  }
}
