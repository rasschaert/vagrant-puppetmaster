# == Class: jepm
#
# Just Enough Puppet Master
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
#  class { jepm:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Kenny Rasschaert <kenny@kennyrasschaert.be>
#
# === Copyright
#
# Copyright 2013 Kenny Rasschaert, unless otherwise noted.
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
  package { "puppet-server":
    ensure  => installed,
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
}

# Class: jepm::service
#
#
class jepm::service {
  service { 'puppetmaster':
    enable => true,
    ensure => running,
    #hasrestart => true,
    #hasstatus => true,
    #require => Class["config"],
  }
}
