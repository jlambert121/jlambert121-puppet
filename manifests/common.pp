# document me
class puppet::common(
  $agent           = $::puppet::agent,
  $ca_server       = $::puppet::ca_server,
  $certname        = $::puppet::server_certname,
  $ensure          = $::puppet::ensure,
  $server          = $::puppet::server,
  $srv_domain      = $::puppet::srv_domain,
  $use_srv_records = $::puppet::use_srv_records,
  $dns_alt_names   = $::puppet::dns_alt_names,
) {

  concat { '/etc/puppetlabs/puppet/puppet.conf':
    ensure => $ensure,
  }

  concat::fragment { 'puppet_main':
    target  => '/etc/puppetlabs/puppet/puppet.conf',
    content => template("${module_name}/puppet.main.erb"),
    order   => '01',
  }

  file { '/etc/puppetlabs/puppet/auth.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/auth.conf.erb"),
  }

}
