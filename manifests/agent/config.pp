# document me
class puppet::agent::config (
  $agent           = $::puppet::agent,
  $environment     = $::puppet::environment,
  $use_srv_records = $::puppet::use_srv_records,
  $puppetmaster    = $::puppet::puppetmaster,
) {

  concat::fragment { 'puppet_agent':
    target  => '/etc/puppet/puppet.conf',
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