# Installs packages required to utilize winbind for joining Active Directory
class winbind::install {
  case $::operatingsystemmajrelease {
    '5'     : {
      package { 'samba3x-winbind':
        ensure => $::winbind::package_ensure,
      }
    }

    default : {
      $packages = ['samba-winbind-clients', 'oddjob-mkhomedir']

      package { $packages:
        ensure => $::winbind::package_ensure,
      }
    }

  }

}
