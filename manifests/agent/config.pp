# document me
class puppet::agent::config (
  $agent           = $::puppet::agent,
  $environment     = $::puppet::environment,
  $use_srv_records = $::puppet::use_srv_records,
  $puppetmaster    = $::puppet::puppetmaster,
  $runinterval     = $::puppet::runinterval,
) {

  if $environment {
    $_environment = $environment
  } else {
    $_environment = $::environment
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
