class jepm {
  case $::osfamily {
    'RedHat', 'CentOS': {
      $puppetmaster_package = 'puppet-server'
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
          warning("unknown version: ${::operatingsystemrelease}")
        }
      }
      package { "$puppetmaster_package":
        ensure  => installed,
        require => Package['puppetlabs-release'],
      }
    }

    'Debian', 'Ubuntu': {
      $puppetmaster_package = 'puppetmaster'
      package { "$puppetmaster_package":
        ensure  => installed,
      }
    }

    default: {}
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    content => template("${module_name}/puppet.conf.erb"),
    notify  => Service['puppetmaster'],
  }

  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    content => "*\n",
    notify  => Service['puppetmaster'],
  }

  service { 'puppetmaster':
    ensure  => running,
    enable  => true,
    require => Package["$puppetmaster_package"],
  }
}
