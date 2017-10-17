# Controls the services related to winbind
class winbind::service inherits winbind {
  case $facts['os']['family'] {
    'RedHat'  : {
      if versioncmp($facts['os']['release']['major'], '7') < 0 {
        if ($winbind::manage_messagebus_service == true) {
          service { 'messagebus':
            ensure => 'running',
            enable => true,
            before => Service['oddjobd'],
          }
        }

        if ($winbind::manage_oddjob_service == true) {
          service { 'oddjobd':
            ensure    => 'running',
            enable    => true,
            subscribe => File['/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf'],
          }
        }

        if ($winbind::enable_sharing == true and $winbind::manage_samba_service == true) {
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
        if ($winbind::manage_oddjob_service == true) {
          service { 'oddjobd':
            ensure    => 'running',
            name      => 'oddjobd.service',
            enable    => true,
            subscribe => File['/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf'],
          }
        }

        if ($winbind::enable_sharing == true and $winbind::manage_samba_service == true) {
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
      if ($winbind::enable_sharing == true and $winbind::manage_samba_service == true) {
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
      fail("The ${facts['os']['family']} OS family is not supported by this module yet.")
    }

  } # end case
}
