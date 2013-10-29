class puppet::run {
  notify { 'puppet agent':
    message => 'Now running puppet agent until it succeeds, which might take a few minutes.',
  }

  exec { '/vagrant/puppet-repeat.bash':
    require => Notify['puppet agent'],
    timeout => 0,
  }
}
