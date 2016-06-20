# Installs packages required to utilize winbind for joining Active Directory
class winbind::install (
  $package_ensure = $::winbind::package_ensure,
  ) {
  case $::osfamily {
    'RedHat' : {
      case $::operatingsystemmajrelease {
        '5'     : {
          package { 'samba3x-winbind':
            ensure => $package_ensure,
          }
        }

        default : {
          $packages = ['samba-winbind-clients', 'oddjob-mkhomedir']

          package { $packages:
            ensure => $package_ensure,
          }
        }

      }
    } # end RedHat

    'Suse' : {
      package { 'samba-winbind':
        ensure => $package_ensure,
      }
    } # end Suse

    default : {
      fail("The ${::osfamily} OS family is not supported by this module yet.")
    }
  } # end osfamily

}
