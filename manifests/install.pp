# Installs packages required to utilize winbind for joining Active Directory
class winbind::install (
  $package_ensure = $::winbind::package_ensure,
  ) {
  case $::osfamily {
    'RedHat' : {
      $packages = ['samba-winbind-clients']

      package { $packages:
        ensure => $package_ensure,
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
