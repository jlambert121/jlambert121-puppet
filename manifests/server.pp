# document me
class puppet::server (
) {
  class { '::puppet::server::install': } ->
  class { '::puppet::server::config': } ~>
  class { '::puppet::server::service': }

  Class['puppet::server::install'] ~> Class['puppet::server::service']
}
