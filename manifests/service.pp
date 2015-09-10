# Controls the services related to winbind
class winbind::service {
  case $::osfamily {
    'RedHat'  : {
      if ($::operatingsystemmajrelease != '7') {
        if $::winbind::manage_messagebus_service == true {
          service { 'messagebus':
            ensure => 'running',
            enable => true,
            before => Service['oddjobd'],
          }
        }

        if $::winbind::manage_oddjob_service == true {
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

        if $::winbind::manage_oddjob_service == true {
          service { 'oddjobd':
            ensure => 'running',
            name   => 'oddjobd.service',
            enable => true,
          }
        }

      } # end else
    } # end RedHat

    default : {
      fail("The ${::osfamily} OS family is not supported by this module yet.")
    }

  } # end case
}
