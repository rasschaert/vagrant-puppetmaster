node 'puppet.vagrant.local' inherits default {
  include puppetmaster
  include stage2

  Class['puppetmaster'] ->
  Class['stage2']
}
