# Controls the services related to winbind
class winbind::service (
  $enable_sharing            = $::winbind::enable_sharing,
  $manage_messagebus_service = $::winbind::manage_messagebus_service,
  $manage_oddjob_service     = $::winbind::manage_oddjob_service,
  $manage_samba_service      = $::winbind::manage_samba_service,
  ) {
  case $::osfamily {
    'RedHat'  : {

      if ($manage_samba_service == true) {
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

    } # end RedHat

    'Suse' : {
      if ($manage_samba_service == true) {
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
