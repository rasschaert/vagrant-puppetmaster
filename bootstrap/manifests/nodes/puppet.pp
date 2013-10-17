node 'puppet.vagrant.local' inherits 'default' {
  include puppetmaster

  notify { 'puppet agent':
    message => 'Now running puppet agent until it succeeds, which takes about 3 runs.',
    require => Class['puppetmaster'],
  }

  exec { '/vagrant/puppet-repeat.bash':
    require => Notify['puppet agent'],
    timeout => 0,
  }
}
