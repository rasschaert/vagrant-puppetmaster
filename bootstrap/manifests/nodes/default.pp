node default {
  include dns::client
  include puppet::run

  Class['dns::client'] ->
  Class['puppet::run']
}
