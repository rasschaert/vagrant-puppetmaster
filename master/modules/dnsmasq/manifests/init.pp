# == Class: dnsmasq
#
# Sets up and configures the lightweight DNSMasq server.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { dnsmasq:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
class dnsmasq (
  $domain_name = 'example.com',
  $upstream_nameservers = ['8.8.8.8', '8.8.4.4'],
){
  package { 'dnsmasq':
    ensure  => installed,
  }

  file { '/etc/dnsmasq.conf':
    ensure  => file,
    require => Package['dnsmasq'],
  }

  file { "/etc/dnsmasq.d/${dnsmasq::domain_name}":
    ensure  => file,
    require => Package['dnsmasq'],
  }
}
