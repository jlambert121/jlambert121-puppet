# document me
class puppet::common(
  $agent           = $::puppet::agent,
  $server          = $::puppet::server,
  $ca_server       = $::puppet::ca_server,
  $ensure          = $::puppet::ensure,
  $use_srv_records = $::puppet::use_srv_records,
  $srv_domain      = $::puppet::srv_domain,
  $puppet_version  = $::puppet::puppet_version,
) {

  if $ensure == 'present' {
    $version = $puppet_version
  } else {
    $version = 'absent'
  }

  package { 'puppet':
    ensure  => $version,
  }

  concat { '/etc/puppet/puppet.conf':
    ensure => $ensure,
  }

  concat::fragment { 'puppet_main':
    target  => '/etc/puppet/puppet.conf',
    content => template("${module_name}/puppet.main.erb"),
    order   => '01',
  }

  file { '/etc/puppet/auth.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/auth.conf.erb"),
  }

}
