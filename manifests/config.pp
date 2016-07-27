class nginx::config inherits ::nginx {

  file { "${config_dir}/nginx.conf":
    ensure  => present,
    content => template('nginx/nginx_conf.erb'),
  }
}
