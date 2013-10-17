node 'puppet.vagrant.local' {
  include puppetmaster
  include dns::entry
  include dns::server

  Class['puppetmaster'] ->
  Class['dns::entry'] ->
  Class['dns::server']
  # include orchestration
}
