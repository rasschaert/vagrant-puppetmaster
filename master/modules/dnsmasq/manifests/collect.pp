# Class: dnsmasq::collect
#
# This class collects exported resources
#
class dnsmasq::collect {
  concat {"/etc/dnsmasq.d/${::domain}.conf":
    owner => root,
    group => root,
    mode  => '0644',
  }

  Concat::Fragment <<| tag == 'dns-entry' |>>
}
