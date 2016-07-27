class nginx::install inherits ::nginx {

  if $package_manage {
    package { $package_name:
      ensure => $package_ensure,
    }
  }
}
