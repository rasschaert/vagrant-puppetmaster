node default {
  include dns::client

  case $::osfamily {
    'Debian', 'Ubuntu': {
      exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
      }
      Exec['apt-get update'] -> Package <| |>
    }
    default: {}
  }
}
