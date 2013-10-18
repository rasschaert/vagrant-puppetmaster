node 'puppet.vagrant.local' {
  include puppet::master
  include puppet::run

  Class['puppet::master'] ->
  Class['puppet::run']
}
