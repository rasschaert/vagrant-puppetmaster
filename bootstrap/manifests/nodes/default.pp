node 'default' {
  case $::osfamily {
    # 'RedHat', 'CentOS': {   }

    # Run apt-get update before trying to install apt packages
    # See StackOverflow question 10845864
    'Debian', 'Ubuntu': {
      @exec { '/usr/bin/sudo /usr/bin/apt-get update':
        tag => apt_update
      }
      Exec <| tag == apt_update |> -> Package <| |>
    }

    default: {
      warning('Unknown OS family.')
    }
  }
}
