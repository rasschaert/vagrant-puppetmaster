# == Class: jepm
#
# Just Enough Puppet Master
#
class jepm {
  include jepm::repo
  include jepm::install
  include jepm::config
  include jepm::service

  Class['jepm::repo'] ->
  Class['jepm::install'] ->
  Class['jepm::config'] ->
  Class['jepm::service']

}

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
            source   => 'http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm',
          }
        }
        /^6/: {
          package { 'puppetlabs-release':
            ensure   => installed,
            provider => rpm,
            source   => 'http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm',
          }
        }
      }
    }
  }
}

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
  }
}

# Class: jepm::config
#
#
class jepm::config {
  file { '/etc/puppet/puppet.conf':
    ensure => file,
    content => template("${module_name}/puppet.conf.erb"),
    notify  => Service['puppetmaster'],
  }
  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    content => "*\n",
    notify  => Service['puppetmaster'],
  }
}

# Class: jepm::service
#
#
class jepm::service {
  service { 'puppetmaster':
    enable => true,
    ensure => running,
  }
}
