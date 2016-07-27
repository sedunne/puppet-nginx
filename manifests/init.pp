class nginx (
  $config_dir          = $nginx::params::config_dir,
  $log_dir             = $nginx::params::log_dir,
  $package_ensure      = $nginx::params::package_ensure,
  $package_manage      = $nginx::params::package_manage,
  $package_name        = $nginx::params::package_name,
  $pid_file            = $nginx::params::pid_file,
  $repo_branch         = $nginx::params::repo_branch,
  $repo_ensure         = $nginx::params::repo_ensure,
  $repo_file           = $nginx::params::repo_file,
  $repo_manage         = $nginx::params::repo_manage,
  $rhel_repo_enable    = $nginx::params::rhel_repo_enable,
  $sites_available_dir = $nginx::params::sites_available_dir,
  $sites_enabled_dir   = $nginx::params::sites_enabled_dir,
  $ssl_dir             = $nginx::params::ssl_dir,
  $user                = $nginx::params::user,
  $worker_processes    = $nginx::params::worker_processes,
  ## non-parameterized options
  $config_settings = [],
  $servers = [],
) inherits ::nginx::params {

  contain ::nginx::repo
  contain ::nginx::install
  contain ::nginx::config

  ## this did work before porting into full module
  ## re-enable once module is ready
  #create_resources('nginx::site', $servers) 
}
