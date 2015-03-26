# document me
class puppet::agent (

){

  class { '::puppet::agent::config': } ~>
  class { '::puppet::agent::service': }

}
