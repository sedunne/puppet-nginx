class nginx::upstream inherits ::nginx {

  file { "${config_dir}/conf.d/upstreams.conf":
    ensure  => present,
    content => template('nginx/upstream.erb'),
  }
}
