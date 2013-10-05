# Class: jepm::install
#
#
class jepm::install {
  case $::osfamily {
    'RedHat', 'CentOS': {
      package { 'puppet-server':
        ensure  => installed,
      }
    }
    'Debian', 'Ubuntu': {
      package { 'puppetmaster':
        ensure  => installed,
      }
    }
    default: {}
  }
}
