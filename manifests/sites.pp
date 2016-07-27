define nginx::site (
  $ensure              = 'present',
  $enabled             = true,
  $purge_sites         = true,
  $servername          = $name,
  $listen_addr         = '80',
  $ssl_listen_addr     = '443',
  $default_server      = undef,
  $ssl_default_server  = $default_server,
  $listen_opts         = undef,
  $ssl_listen_opts     = $listen_opts,
  $root                = undef,
  $index               = 'index.html index.php',
  $log_format          = undef,
  $access_log          = "${::nginx::log_dir}/${servername}.access_log",
  $custom_access_log   = undef,
  $error_log           = "${::nginx::log_dir}/${servername}.error_log",
  $error_log_level     = 'error',
  $extra_options       = undef,
  $locations           = undef,
  $ssl_enabled         = false,
  $ssl_only            = false,
  $ssl_custom_redirect = undef,
) { 

  ## validate vars
  validate_string($ensure)
  validate_bool($enabled)
  validate_bool($purge_sites)
  validate_string($servername)
  validate_string($listen_addr)
  if $default_server != undef {
    validate_bool($default_server)
  }
  if $listen_opts != undef {
    validate_string($listen_opts)
  }
  validate_string($ssl_listen_addr)
  if $ssl_default_server != undef {
    validate_bool($ssl_default_server)
  }
  if $ssl_listen_opts != undef {
    validate_string($ssl_listen_opts)
  }
  if $root != undef {
    validate_string($root)
  }
  validate_string($index)
  if $log_format != undef {
    validate_string($log_format)
  }
  validate_string($access_log)
  if $custom_access_log != undef {
    validate_string($custom_access_log)
  }
  validate_string($error_log)
  validate_re($error_log_level, ['^debug$', '^info$', '^notice$', '^warn$',
                                 '^error$', '^crit$', '^alert$', '^emerg$'])
  if $extra_options != undef {
    validate_hash($extra_options)
  }
  if $locations != undef {
    validate_hash($locations)
  }
  validate_bool($ssl_only)
  if $ssl_custom_redirect {
    validate_string($ssl_custom_redirect)
  }

  ## default server check
  if $default_server {
    $listen_default = 'default_server'
  }
  if $ssl_default_server {
    $ssl_listen_default = 'default_server'
  }

  ## do work son
  if $purge_sites {
    file { $::nginx::sites_available_dir:
      ensure  => directory,
      recurse => true,
      purge   => true,
    }
    file { $::nginx::sites_enabled_dir:
      ensure  => directory,
      recurse => true,
      purge   => true,
    }
  }
  file { "${::nginx::sites_available_dir}/${servername}":
    ensure  => $ensure,
    content => template('nginx/site.erb'),
  }
  if $enabled {
    file { "${::nginx::sites_enabled_dir}/${servername}":
      ensure => link,
      target => "${::nginx::sites_available_dir}/${servername}",
    }
  }
  elsif !$enabled {
    file { "${::nginx::sites_enabled_dir}/${servername}":
      ensure => absent,
    }
  }
}
