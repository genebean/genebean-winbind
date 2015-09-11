# Installs packages required to utilize winbind for joining Active Directory
class winbind::install (
  $package_ensure = $::winbind::package_ensure,
  ) {
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

}
