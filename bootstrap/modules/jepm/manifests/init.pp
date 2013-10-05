# == Class: jepm
#
# Just Enough Puppet Master
#
class jepm {
  include jepm::repo
  include jepm::install
  include jepm::config
  include jepm::service

  Class['jepm::repo'] ->
  Class['jepm::install'] ->
  Class['jepm::config'] ->
  Class['jepm::service']
}
