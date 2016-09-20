# document me
class puppet::server::config (
  $ca_enabled            = $::puppet::server_ca_enabled,
  $config_dir            = $::puppet::params::server_config_dir,
  $fileserver            = $::puppet::fileserver_conf,
  $manage_hiera          = $::puppet::manage_hiera,
  $hiera_source          = $::puppet::hiera_source,
  $java_opts             = $::puppet::server_java_opts,
  $bootstrap_dir         = $::puppet::server_bootstrap_dir,
  $log_dir               = $::puppet::server_log_dir,
  $log_file              = $::puppet::server_log_file,
  $server                = $::puppet::server,
  $server_version        = $::puppet::server_version,
  $runinterval           = $::puppet::runinterval,
  $puppetdb              = $::puppet::puppetdb,
  $puppetdb_port         = $::puppet::puppetdb_port,
  $puppetdb_server       = $::puppet::puppetdb_server,
  $manage_puppetdb       = $::puppet::manage_puppetdb,
  $reports               = $::puppet::server_reports,
  $firewall              = $::puppet::firewall,
  $jruby_instances       = $::puppet::jruby_instances,
  $use_legacy_auth       = $::puppet::use_legacy_auth,
  $server_ssl_cert       = $::puppet::server_ssl_cert,
  $server_ssl_key        = $::puppet::server_ssl_key,
  $server_ssl_ca_cert    = $::puppet::server_ssl_ca_cert,
  $server_ssl_cert_chain = $::puppet::server_ssl_cert_chain,
  $server_ssl_crl_path   = $::puppet::server_ssl_crl_path,
) {

  $file_ensure = $server ? {
    true    => 'file',
    default => 'absent'
  }

  File {
    ensure => $file_ensure,
    owner  => 'puppet',
    group  => 'puppet',
  }

  case $server_version {
    /(\d+\.\d+)\.\d+\-\d+.*/: {
      $config = 0 + $1 # This must be a float 
    }
    'latest': {
      # There is a breaking confign change for version 2.6 and later.
      $config = 2.6

    }
    default: {
      $config = 2.5
    }
  }

  if (
      $config >= 2.6
    ) and (
      $bootstrap_dir == $::puppet::params::server_bootstrap_dir
    ) {
      $parsed_bootstrap_dir  = '/etc/puppetlabs/puppetserver/services.d/,/opt/puppetlabs/server/apps/puppetserver/config/services.d/'
      $bootstrap_install_dir = '/opt/puppetlabs/server/apps/puppetserver/config/services.d'
  } else {
      $parsed_bootstrap_dir = $bootstrap_dir
      $bootstrap_install_dir = '/etc/puppetlabs/puppetserver'
  }

  


  if $server {
    file { $log_dir:
      ensure => 'directory',
      mode   => '0750',
    }

    # Template uses
    # - $ca_enabled
    # - $puppetdb
    # - $reports
    concat::fragment { 'puppet_master':
      target  => '/etc/puppetlabs/puppet/puppet.conf',
      content => template("${module_name}/puppet.master.erb"),
      order   => '10',
    }
  }

  # Template uses
  # - $parsed_bootstrap_dir
  # - $java_opts
  file { "${config_dir}/puppetserver":
    content => template("${module_name}/server/puppetserver.sysconfig.erb"),
  }

  # Template uses
  # - $ca_enabled
  file { "${bootstrap_install_dir}/bootstrap.cfg":
    content => template("${module_name}/server/bootstrap.cfg.erb"),
  }

  # Template uses
  # - $server_log_dir
  # - $server_log_file
  file { '/etc/puppetlabs/puppetserver/logback.xml':
    content => template("${module_name}/server/logback.xml.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/request-logging.xml':
    content => template("${module_name}/server/request-logging.xml.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/ca.conf':
    content => template("${module_name}/server/ca.conf.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/global.conf':
    content => template("${module_name}/server/global.conf.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf':
    content => template("${module_name}/server/puppetserver.conf.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/web-routes.conf':
    content => template("${module_name}/server/web-routes.conf.erb"),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/webserver.conf':
    content => template("${module_name}/server/webserver.conf.erb"),
  }

  if ( $server and $hiera_source and $manage_hiera) {
    file { '/etc/puppetlabs/code/hiera.yaml':
      source => $hiera_source,
    }
  } elsif $manage_hiera {
    file { '/etc/puppetlabs/code/hiera.yaml':
      ensure => 'absent',
    }
  }

  if ( $server and $fileserver ) {
    # Template uses
    # - $fileserver
    file { '/etc/puppetlabs/puppet/fileserver.conf':
      content => template('puppet/server/fileserver.conf.erb'),
    }
  }

  if ( $server and $puppetdb and $manage_puppetdb) {
    file { '/etc/puppetlabs/puppet/routes.yaml':
      source => 'puppet:///modules/puppet/routes.yaml',
    }

    # Template uses
    # - $puppetdb_port
    # - $puppetdb_server
    file { '/etc/puppetlabs/puppet/puppetdb.conf':
      content => template('puppet/server/puppetdb.conf.erb'),
    }
  }

  if $firewall {
    # Allow inbound connections
    firewall { '500 allow inbound connections to puppetserver':
      action => 'accept',
      state  => 'NEW',
      dport  => '8140',
    }
  }
}
