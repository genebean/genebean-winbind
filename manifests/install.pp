# Installs packages required to utilize winbind for joining Active Directory
class winbind::install inherits winbind {
  case $facts['os']['family'] {
    'RedHat' : {
      $_packages = ['samba-winbind-clients', 'oddjob-mkhomedir']

      package { $_packages:
        ensure => $winbind::package_ensure,
      }

      if ($winbind::enable_sharing) {
        package { 'samba':
          ensure => $winbind::package_ensure,
        }
      }
    } # end RedHat

    'Suse' : {
      package { 'samba-winbind':
        ensure => $winbind::package_ensure,
      }

      if ($winbind::enable_sharing) {
        package { 'samba':
          ensure => $winbind::package_ensure,
        }
      }
    } # end Suse

    default : {
      fail("The ${facts['os']['family']} OS family is not supported by this module yet.")
    }
  } # end osfamily

}
