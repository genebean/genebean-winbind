# Installs packages required to utilize winbind for joining Active Directory
class winbind::install {
  $packages = ['samba-winbind-clients', 'oddjob-mkhomedir']

  package { $packages: ensure => 'latest', }
}
