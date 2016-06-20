# Definition winbind::share
#
# This class setups up a config file to be included into smb.conf
#
define winbind::share (
  $ensure_setting  = present,
  $settings_hash   = undef,
  $smb_include_dir = $::winbind::smb_includes_dir,
) {

  file { "${smb_include_dir}/${title}.conf":
    ensure  => $ensure_setting,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/share.erb'),
    require => File[$smb_include_dir],
    notify  => Service['smb'],
  }
}
