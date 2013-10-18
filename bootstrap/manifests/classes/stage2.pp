class stage2 {
  notify { 'puppet agent':
    message => 'Now running puppet agent until it succeeds, which takes about 3 runs.',
  }

  exec { '/vagrant/puppet-repeat.bash':
    require => Notify['puppet agent'],
    timeout => 0,
  }
}
