# Class: jepm::repo
#
#
class jepm::repo {
  case $::osfamily {
    'RedHat', 'CentOS': {
      case $::operatingsystemrelease {
        /^5/: {
          package { 'puppetlabs-release':
            ensure   => installed,
            provider => rpm,
            source   =>
              'http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm',
          }
        }
        /^6/: {
          package { 'puppetlabs-release':
            ensure   => installed,
            provider => rpm,
            source   =>
              'http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm',
          }
        }
        default: {
          notice => "unknown version: ${::operatingsystemrelease}".
        }
      }
    }
    default: {}
  }
}
