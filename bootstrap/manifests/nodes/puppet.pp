node 'puppet.vagrant.local' {
# The firewall is disabled
# This is a temporary measure until I add and configure the firewall module
# to this project. I need to open up 8140 TCP for the Puppet web server,
# 8081 TCP for the PuppetDB secure PostgreSQL and 53 UDP & TCP for DNS.
  service { "iptables":
    enable => false,
    ensure => stopped,
  }

  include jepm
  include puppet::run

  Service['iptables'] ->
  Class['jepm'] ->
  Class['puppet::run']
}
