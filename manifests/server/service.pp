# document me
class puppet::server::service (
  $server = $::puppet::server,
) {

  if $server {
    service { 'puppetserver':
      ensure => 'running',
      enable => true,
    }
  }
}
