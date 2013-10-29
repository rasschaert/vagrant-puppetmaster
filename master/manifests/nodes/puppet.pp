node 'puppet.vagrant.local' {
  include puppetmaster
  include dns::entry
  include dns::server
  include dns::client

  Class['puppetmaster'] ->
  Class['dns::entry'] ->
  Class['dns::server'] ->
  Class['dns::client']
}
