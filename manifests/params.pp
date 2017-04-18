# document me
class puppet::params {

  $agent_version = 'latest'
  $ca_server = undef
  $use_srv_records = false
  $srv_domain = undef
  $runmode = 'cron'
  $env = undef
  $puppetmaster = "puppet.${::domain}"

  $dns_alt_names = undef
  $autosign = undef
  $fileserver_conf = undef
  $manage_hiera = true
  $hiera_source = undef
  $puppetdb = false
  $puppetdb_port = 8081
  $puppetdb_server = undef
  $puppetdb_version = 'latest'
  $manage_puppetdb = true
  $runinterval = '30m'
  $server_ca_enabled = true
  $server_certname = undef
  $server_java_opts = '-Xms2g -Xmx2g'
  $server_log_dir = '/var/log/puppetlabs/puppetserver'
  $server_log_file = 'puppetserver.log'
  $server_reports = undef
  $server_version = 'latest'
  $firewall = false
  $jruby_instances = $::processors[count]-1
  $use_legacy_auth = false
  $server_ssl_cert = undef
  $server_ssl_key = undef
  $server_ssl_ca_cert = undef
  $server_ssl_cert_chain = undef
  $server_ssl_crl_path = undef


  case $::osfamily {
    'Debian': {
      $server_config_dir = '/etc/default'
    }
    'RedHat': {
      $server_config_dir = '/etc/sysconfig'
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }
}
