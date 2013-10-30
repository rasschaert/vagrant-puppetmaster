# Class: puppet::run
# Run the puppet agent
class puppet::run {
  notify { 'puppet agent':
    message => 'Now running puppet agent until it succeeds.',
  }

  exec { '/vagrant/puppet-repeat.bash':
    require => Notify['puppet agent'],
    timeout => 0,
  }
}
