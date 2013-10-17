node 'puppet.vagrant.local' inherits 'default' {
  include puppetmaster

  exec { '/vagrant/puppet-repeat.bash':
    require => Class['puppetmaster'],
    timeout => 0,
  }
}
