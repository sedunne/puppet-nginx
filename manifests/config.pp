class nginx::config inherits ::nginx {

  file { "${config_dir}/nginx.conf":
    ensure  => present,
    content => template('nginx/nginx_conf.erb'),
  }

  file {"${config_dir}/conf.d":
    ensure => directory,
  }
}
