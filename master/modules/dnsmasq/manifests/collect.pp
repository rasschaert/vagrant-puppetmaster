# Class: dnsmasq::collect
#
# This class collects exported resources
#
class dnsmasq::collect {
  concat {"/etc/hosts.dnsmasq":
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service['dnsmasq'],
  }

  Concat::Fragment <<| tag == 'dns-entry' |>>
}
