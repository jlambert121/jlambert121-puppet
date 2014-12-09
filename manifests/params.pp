# document me
class puppet::params {

  $puppet_version = 'latest'
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
  $server_log_dir = '/var/log/puppetserver'
  $server_log_file = 'puppetserver.log'
  $server_reports = undef
  $server_version = 'latest'

  case $::osfamily {
    'Debian': {
      $server_ruby_paths = '/usr/lib/ruby/vendor_ruby/'
      $server_config_dir = '/etc/default'
    }
    'RedHat': {
      case $::operatingsystemmajrelease {
        6: {
          $server_ruby_paths = '/usr/lib/ruby/site_ruby/1.8'
        }
        default: {
          $server_ruby_paths = '/usr/share/ruby/vendor_ruby/'
        }
      }
      $server_config_dir = '/etc/sysconfig'
    }
    default: {
      fail("${::osfaily} is not supported.")
    }
  }
}