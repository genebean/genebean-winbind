# Controls the services related to winbind
class winbind::service {
  case $::osfamily {
    RedHat  : {
      if ($::operatingsystemmajrelease < 7) {
        service { 'oddjobd':
          ensure => 'running',
          enable => true,
        }

        service { 'winbind':
          ensure => 'running',
          enable => true,
        }

      } else {
        service { 'winbind.service':
          ensure => 'running',
          enable => true,
        }

        service { 'oddjobd.service':
          ensure => 'running',
          enable => true,
        }

      } # end else
    } # end RedHat

    default : {
      fail("The ${::osfamily} OS family is not supported by this module yet.")
    }

  } # end case
}
