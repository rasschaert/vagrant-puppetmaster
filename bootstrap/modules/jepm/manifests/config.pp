# Class: jepm::config
#
#
class jepm::config {
  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    content => template("${module_name}/puppet.conf.erb"),
    notify  => Service['puppetmaster'],
  }
  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    content => "*\n",
    notify  => Service['puppetmaster'],
  }
}
