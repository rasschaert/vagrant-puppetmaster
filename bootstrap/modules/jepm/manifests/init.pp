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
            before   => Package["$puppetmaster_package"],
          }
        }
        /^6/: {
          package { 'puppetlabs-release':
            ensure   => installed,
            provider => rpm,
            source   =>
              'http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm',
            before   => Package["$puppetmaster_package"],
          }
        }
        default: {
          warning("unknown version: ${::operatingsystemrelease}")
        }
      }
    }

    'Debian': {
      $puppetmaster_package = 'puppetmaster'

      file { '/etc/apt/sources.list.d/puppetlabs.list':
        ensure  => file,
        content => template("${module_name}/puppetlabs.list.erb"),
        owner   => root,
        group   => root,
      }

      file { '/etc/apt/trusted.gpg.d/puppetlabs-keyring.gpg':
        ensure  => file,
        source  => "puppet:///modules/${module_name}/puppetlabs-keyring.gpg",
        owner   => root,
        group   => root,
      }

      exec {'apt-get update':
        path    => ['/usr/bin'],
        user    => 'root',
        require => [
          File['/etc/apt/sources.list.d/puppetlabs.list'],
          File['/etc/apt/trusted.gpg.d/puppetlabs-keyring.gpg'],
        ],
        before  => Package["$puppetmaster_package"],
      }
    }

    default: {}
  }

  package { "$puppetmaster_package":
    ensure  => latest,
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    content => template("${module_name}/puppet.conf.erb"),
    notify  => Service['puppetmaster'],
    require => Package["$puppetmaster_package"],
  }

  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    content => "*\n",
    notify  => Service['puppetmaster'],
    require => Package["$puppetmaster_package"],
  }

  service { 'puppetmaster':
    ensure  => running,
    enable  => true,
    require => Package["$puppetmaster_package"],
  }
}
