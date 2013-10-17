node 'puppet.vagrant.local' {
  include puppetmaster
  include dns::server

  Class['puppetmaster'] ->
  Class['dns::server']
  # include orchestration
}
