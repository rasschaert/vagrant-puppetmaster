# Class: jepm::service
#
#
class jepm::service {
  service { 'puppetmaster':
    ensure => running,
    enable => true,
  }
}
