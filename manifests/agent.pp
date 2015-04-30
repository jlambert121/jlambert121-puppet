# document me
class puppet::agent (

){

  class { '::puppet::agent::install': } ->
  class { '::puppet::agent::config': } ~>
  class { '::puppet::agent::service': }
  Class['puppet::agent::install'] ~> Class['puppet::agent::service']

}
