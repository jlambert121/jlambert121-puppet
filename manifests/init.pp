#
class puppet (
  $agent                  = true,
  $server                 = false,
  $puppet_version         = $::puppet::params::puppet_version,
  $ca_server              = $::puppet::params::ca_server,
  $use_srv_records        = $::puppet::params::use_srv_records,
  $srv_domain             = $::puppet::params::srv_domain,
  $runmode                = $::puppet::params::runmode,
  $environment            = $::puppet::params::environment,
  $puppetmaster           = $::puppet::params::puppetmaster,

  # Server
  $dns_alt_names          = $::puppet::params::dns_alt_names,
  $fileserver_conf        = $::puppet::params::fileserver_conf,
  $hiera_source           = $::puppet::params::hiera_source,
  $puppetdb               = $::puppet::params::puppetdb,
  $puppetdb_port          = $::puppet::params::puppetdb_port,
  $puppetdb_server        = $::puppet::params::puppetdb_server,
  $puppetdb_version       = $::puppet::params::puppetdb_version,
  $server_ca_enabled      = $::puppet::params::server_ca_enabled,
  $server_certname        = $::puppet::params::server_certname,
  $server_java_opts       = $::puppet::params::server_java_opts,
  $server_log_dir         = $::puppet::params::server_log_dir,
  $server_log_file        = $::puppet::params::server_log_file,
  $server_reports         = $::puppet::params::server_reports,
  $server_ruby_paths      = $::puppet::params::server_ruby_paths,
  $server_version         = $::puppet::params::server_version,
) inherits puppet::params {

  validate_bool($use_srv_records)
  validate_bool($puppetdb)
  validate_bool($server_ca_enabled)

  validate_re($runmode, ['cron', 'service', 'none'], 'Puppet: valid values for runmode are cron, service, and none')

  if $hiera_source {
    validate_re($hiera_source, '^puppet', 'Puppet: hiera_source must be a puppet resource')
  }

  if !is_integer($puppetdb_port) {
    fail("Puppet:: puppetdb_port must be an integer (got ${puppetdb_port})")
  }

  if $puppetdb and !$puppetdb_server {
    fail('Puppet: puppetdb_server is required with puppetdb')
  }

  if $fileserver_conf and !is_hash($fileserver_conf) {
    fail('Puppet: fileserver_conf must be a of hash of mountpoints')
  }

  if ( $agent or $server ) {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  class { 'puppet::common': }

  class { 'puppet::agent':
    require => Class['puppet::common'],
    } ->

  class { 'puppet::server':
    require => Class['puppet::common'],
  }

}