# Configures settings associated with using winbind to join Active Directory
#
# Example settings hash that could be included in local profile manifest:
#
#  $smb_settings_hash = {
#    'share1' => {
#      'path'      => '/tmp',
#      'browsable' => 'yes',
#      'read only' => 'yes'
#    },
#    'share2' => {
#      'path'      => '/mnt',
#      'browsable' => 'no',
#      'read only' => 'yes'
#    },
#  }
class winbind::config inherits winbind {

  if $winbind::manage_joindomain_script {
    $joindomain = $facts['os']['family'] ? {
      'RedHat' => 'joinDomainForRedHat.sh',
      'Suse'   => 'joinDomainForSUSE.sh',
      'Debian' => 'joinDomainForDebian.sh',
      default  => 'joindomainForRedHat.sh',
    }

    file { '/root/joinDomain.sh':
      ensure => 'file',
      mode   => '0755',
      source => "puppet:///modules/winbind/${joindomain}",
    }
  }

  file { '/etc/krb5.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('winbind/krb5.conf.epp'),
    notify  => Service['winbind'],
  }

  if $facts['os']['family'] == 'RedHat' {
    file { '/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('winbind/oddjobd-mkhomedir.conf.epp'),
      notify  => Service['winbind'],
    }
  }

  file { '/etc/samba/smb.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('winbind/smb.conf.epp'),
    notify  => Service['winbind'],
  }

  file { $winbind::smb_includes_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['winbind'],
  }

  file { '/etc/security/pam_winbind.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('winbind/pam_winbind.conf.epp'),
    notify  => Service['winbind'],
  }

  if ($winbind::smb_settings_hash) {
    $defaults = {
      'path' => "${winbind::smb_includes_dir}/smb-extras.conf"
    }
    create_ini_settings($winbind::smb_settings_hash, $defaults)
  }

}
