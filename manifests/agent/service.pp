# document me
class puppet::agent::service (
  $runmode = $::puppet::runmode,
){

  if ( $::puppet::agent ) {
    $mode = $runmode
  } else {
    $mode = 'none'
  }

  case $runmode {
    'cron': {
      case $::kernel {
        'Windows': {
          scheduled_task { 'puppet':
            ensure    => 'present',
            command   => 'C:\\Program Files\\Puppet Labs\\Puppet\\bin\\puppet.bat',
            arguments => 'agent --onetime --no-daemonize',
            trigger   => {
              schedule         => daily,
              start_time       => '00:00',
              minutes_interval => 30,
              minutes_duration => 31,
            }
          }
        }
        'Linux': {
          cron { 'puppet':
            ensure  => 'present',
            user    => 'root',
            command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize',
            hour    => '*',
            minute  =>  [ fqdn_rand(30), fqdn_rand(30) + 30 ],
          }
        }
      }
      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    'service': {
      case $::osfamily {
        'Windows': {
          scheduled_task { 'puppet':
            ensure => 'absent',
          }
        }
        'Linux': {
          cron { 'puppet':
            ensure => 'absent',
          }
        }
      }
      service { 'puppet':
        ensure => 'running',
        enable => true,
      }
    }
    'none': {
      case $::kernel {
        'Windows': {
          scheduled_task { 'puppet':
            ensure => 'absent',
          }
        }
        'Linux': {
          cron { 'puppet':
            ensure => 'absent',
          }
        }
      }
      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    default: {
      fail("Unsupported runmode ${runmode} in puppet::agent::service")
    }
  }
}
