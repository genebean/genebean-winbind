# Controls the services related to winbind
class winbind::service (
  $manage_messagebus_service = $::winbind::manage_messagebus_service,
  $manage_oddjob_service     = $::winbind::manage_oddjob_service,
  ) {
  case $::osfamily {
    'RedHat'  : {
      if ($::operatingsystemmajrelease != '7') {
        if ($manage_messagebus_service == true) {
          service { 'messagebus':
            ensure => 'running',
            enable => true,
            before => Service['oddjobd'],
          }
        }

        if ($manage_oddjob_service == true) {
          service { 'oddjobd':
            ensure => 'running',
            enable => true,
          }
        }

        service { 'winbind':
          ensure => 'running',
          enable => true,
        }

      } else {
        service { 'winbind':
          ensure => 'running',
          name   => 'winbind.service',
          enable => true,
        }

        if ($manage_oddjob_service == true) {
          service { 'oddjobd':
            ensure => 'running',
            name   => 'oddjobd.service',
            enable => true,
          }
        }

      } # end else
    } # end RedHat

    'Suse' : {
      service { 'winbind':
        ensure => 'running',
        enable => true,
      }
    } # end Suse

    default : {
      fail("The ${::osfamily} OS family is not supported by this module yet.")
    }

  } # end case
}
