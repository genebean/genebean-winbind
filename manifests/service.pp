# Controls the services related to winbind
class winbind::service (
  $enable_sharing            = $::winbind::enable_sharing,
  $manage_messagebus_service = $::winbind::manage_messagebus_service,
  $manage_oddjob_service     = $::winbind::manage_oddjob_service,
  $manage_samba_service      = $::winbind::manage_samba_service,
  ) {
  case $::osfamily {
    'RedHat'  : {
      if versioncmp($::operatingsystemmajrelease, '7') < 0 {
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

        if ($enable_sharing == true and $manage_samba_service == true) {
          service { 'smb':
            ensure => 'running',
            enable => true,
          }
        }

        service { 'winbind':
          ensure => 'running',
          enable => true,
        }

      } else {
        if ($manage_oddjob_service == true) {
          service { 'oddjobd':
            ensure => 'running',
            name   => 'oddjobd.service',
            enable => true,
          }
        }

        if ($enable_sharing == true and $manage_samba_service == true) {
          service { 'smb':
            ensure => 'running',
            enable => true,
          }
        }

        service { 'winbind':
          ensure => 'running',
          name   => 'winbind.service',
          enable => true,
        }

      } # end else
    } # end RedHat

    'Suse' : {
      if ($enable_sharing == true and $manage_samba_service == true) {
        service { 'smb':
          ensure => 'running',
          enable => true,
        }
      }
      
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
