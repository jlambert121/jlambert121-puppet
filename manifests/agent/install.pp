class puppet::agent::install (
  Boolean $agent         = $::puppet::agent,
  String  $agent_version = $::puppet::agent_version,

){

  # puppetserver depends on agent, don't remove it if agent is false
  if $agent {
    package { 'puppet-agent':
      ensure  => $agent_version,
    }
  }

}