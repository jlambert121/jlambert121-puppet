# document me
class puppet::server::config (
  $ca_enabled      = $::puppet::server_ca_enabled,
  $config_dir      = $::puppet::params::server_config_dir,
  $dns_alt_names   = $::puppet::dns_alt_names,
  $fileserver      = $::puppet::fileserver_conf,
  $hiera_source    = $::puppet::hiera_source,
  $java_opts       = $::puppet::server_java_opts,
  $log_dir         = $::puppet::server_log_dir,
  $log_file        = $::puppet::server_log_file,
  $server          = $::puppet::server,
  $puppetdb        = $::puppet::puppetdb,
  $puppetdb_port   = $::puppet::puppetdb_port,
  $puppetdb_server = $::puppet::puppetdb_server,
  $reports         = $::puppet::server_reports,
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

  if $server {
    file { $log_dir:
      ensure => 'directory',
    }

    # Template uses
    # - $ca_enabled
    # - $dns_alt_names
    # - $hiera_source
    # - $puppetdb
    # - $reports
    concat::fragment { 'puppet_master':
      target  => '/etc/puppetlabs/puppet/puppet.conf',
      content => template("${module_name}/puppet.master.erb"),
      order   => '10',
    }
  }

  # Template uses
  # - $java_opts
  file { "${config_dir}/puppetserver":
    content => template("${module_name}/server/puppetserver.sysconfig.erb"),
  }

  # Template uses
  # - $ca_enabled
  file { '/etc/puppetlabs/puppetserver/bootstrap.cfg':
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

  if ( $server and $hiera_source ) {
    file { '/etc/puppetlabs/code/hiera.yaml':
      source => $hiera_source,
    }
  } else {
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

  if ( $server and $puppetdb) {
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
}
