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

  file { '/etc/krb5.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/krb5.conf.erb'),
    notify  => Service['winbind'],
  }

  if $::osfamily == 'RedHat' {
    file { '/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('winbind/oddjobd-mkhomedir.conf.erb'),
      notify  => Service['winbind'],
    }
  }

  file { '/etc/samba/smb.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/smb.conf.erb'),
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
    content => template('winbind/pam_winbind.conf.erb'),
    notify  => Service['winbind'],
  }

  if ($winbind::smb_settings_hash) {
    $defaults = {
      'path' => "${winbind::smb_includes_dir}/smb-extras.conf"
    }
    create_ini_settings($winbind::smb_settings_hash, $defaults)
  }

}
