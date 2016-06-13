# document me
class puppet::agent::config (
  $agent           = $::puppet::agent,
  $env             = $::puppet::env,
  $use_srv_records = $::puppet::use_srv_records,
  $puppetmaster    = $::puppet::puppetmaster,
  $runinterval     = $::puppet::runinterval,
  $report          = $::puppet::report,
) {

  if $env == undef {
    $env_real = $::environment
  }
  else {
    $env_real = $env
  }

  concat::fragment { 'puppet_agent':
    target  => '/etc/puppetlabs/puppet/puppet.conf',
    content => template("${module_name}/puppet.agent.erb"),
    order   => '05',
  }

  if $::osfamily == 'Debian' {
    if $agent {
      $start = 'yes'
    } else {
      $start = 'no'
    }

    file { '/etc/default/puppet':
      content => inline_template('START=<%= @start %>'),
    }
  }
}
