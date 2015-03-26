# document me
class puppet::server::config (
  $ca_enabled      = $::puppet::server_ca_enabled,
  $certname        = $::puppet::server_certname,
  $config_dir      = $::puppet::params::server_config_dir,
  $fileserver      = $::puppet::fileserver_conf,
  $hiera_source    = $::puppet::hiera_source,
  $java_opts       = $::puppet::server_java_opts,
  $log_dir         = $::puppet::server_log_dir,
  $log_file        = $::puppet::server_log_file,
  $ruby_paths      = $::puppet::server_ruby_paths,
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
    # - $certname
    # - $hiera_source
    # - $puppetdb
    # - $reports
    concat::fragment { 'puppet_master':
      target  => '/etc/puppet/puppet.conf',
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
  file { '/etc/puppetserver/bootstrap.cfg':
    content => template("${module_name}/server/bootstrap.cfg.erb"),
  }

  # Template uses
  # - $server_log_dir
  # - $server_log_file
  file { '/etc/puppetserver/logback.xml':
    content => template("${module_name}/server/logback.xml.erb"),
  }

  file { '/etc/puppetserver/conf.d/ca.conf':
    content => template("${module_name}/server/ca.conf.erb"),
  }

  file { '/etc/puppetserver/conf.d/global.conf':
    content => template("${module_name}/server/global.conf.erb"),
  }

  # Template uses
  # - $ruby_paths
  file { '/etc/puppetserver/conf.d/os-settings.conf':
    content => template("${module_name}/server/os-settings.conf.erb"),
  }

  file { '/etc/puppetserver/conf.d/puppetserver.conf':
    content => template("${module_name}/server/puppetserver.conf.erb"),
  }

  file { '/etc/puppetserver/conf.d/webserver.conf':
    content => template("${module_name}/server/webserver.conf.erb"),
  }

  if ( $server and $hiera_source ) {
    file { '/etc/puppet/hiera.yaml':
      source => $hiera_source,
    }
  }

  if ( $server and $fileserver ) {

    # Template uses
    # - $fileserver
    file { '/etc/puppet/fileserver.conf':
      content => template('puppet/server/fileserver.conf.erb'),
    }
  }

  if ( $server and $puppetdb) {
    file { '/etc/puppet/routes.yaml':
      source => 'puppet:///modules/puppet/routes.yaml',
    }

    # Template uses
    # - $puppetdb_port
    # - $puppetdb_server
    file { '/etc/puppet/puppetdb.conf':
      content => template('puppet/server/puppetdb.conf.erb'),
    }
  }
}
