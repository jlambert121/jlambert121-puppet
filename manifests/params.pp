# document me
class puppet::params {

  $agent_version = 'latest'
  $ca_server = undef
  $use_srv_records = false
  $srv_domain = undef
  $runmode = 'cron'
  $environment = 'production'
  $puppetmaster = "puppet.${::domain}"

  $dns_alt_names = undef
  $fileserver_conf = undef
  $hiera_source = undef
  $puppetdb = false
  $puppetdb_port = 8081
  $puppetdb_server = undef
  $puppetdb_version = 'latest'
  $server_ca_enabled = true
  $server_certname = undef
  $server_java_opts = '-Xms2g -Xmx2g -XX:MaxPermSize=256m'
  $server_log_dir = '/var/log/puppetlabs/puppetserver'
  $server_log_file = 'puppetserver.log'
  $server_reports = undef
  $server_version = 'latest'
  $firewall = false

  case $::osfamily {
    'Debian': {
      $server_config_dir = '/etc/default'
    }
    'RedHat': {
      $server_config_dir = '/etc/sysconfig'
    }
    default: {
      fail("${::osfaily} is not supported.")
    }
  }
}