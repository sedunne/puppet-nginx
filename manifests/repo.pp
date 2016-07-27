class nginx::repo inherits ::nginx {

  if $repo_manage {
    case $::osfamily {
      'RedHat': {
        file { $repo_file:
          ensure  => $repo_ensure,
          content => template('nginx/repo/rhel.erb'),
        }
      }
      'Debian': {
        file { $repo_file:
          ensure => $repo_ensure,
          content => template('nginx/repo/deb.erb'),
        }
      }
      default: {
        fail("Module ${module_name} cannot manage repository on ${::operatingsystem}")
      }
    }
  }
}
