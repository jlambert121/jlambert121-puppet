# document me
class puppet::server::install (
  $puppetdb         = $::puppet::puppetdb,
  $puppetdb_version = $::puppet::puppetdb_version,
  $server           = $::puppet::server,
  $server_version   = $::puppet::server_version,
) {

  $_server_version = $server ? {
    true    => $server_version,
    default => 'absent'
  }

  if $server {
    $_puppetdb_version = $puppetdb ? {
      true    => $puppetdb_version,
      default => 'absent'
    }
  } else {
    $_puppetdb_version = 'absent'
  }

  package { 'puppetserver':
    ensure => $_server_version,
  }

  package { 'puppetdb-terminus':
    ensure => $_puppetdb_version,
  }

  # Set up environments
  file { '/etc/puppet/environments':
    ensure => 'directory',
    mode   => '0755',
  }

  # Remove old dirs to avoid confusion
  file { ['/etc/puppet/modules', '/etc/puppet/manifests']:
    ensure  => 'absent',
    purge   => true,
    recurse => true,
    force   => true,
    require => Package['puppetserver'],
  }
}
