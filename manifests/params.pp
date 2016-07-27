class nginx::params {

  $config_dir          = '/etc/nginx'
  $log_dir             = '/var/log/nginx'
  $package_ensure      = 'present'
  $package_manage      = true
  $package_name        = 'nginx'
  $pid_file            = '/run/nginx.pid'
  $repo_branch         = 'stable'
  $repo_ensure         = 'present'
  $repo_manage         = true
  $rhel_repo_enable    = true
  $sites_enabled_dir   = "${config_dir}/sites-enabled"
  $sites_available_dir = "${config_dir}/sites-available"
  $ssl_dir             = "${config_dir}/ssl"
  $worker_processes    = 'auto'

  ## os specific stuff
  if $::osfamily == 'RedHat' {
    $repo_file = '/etc/yum.repos.d/nginx.repo'
    $user      = 'nginx'
  }
  elsif $::osfamily == 'Debian' {
    $repo_file = '/etc/apt/sources.list.d/nginx.list'
    $user      = 'www-data'
  }
}
