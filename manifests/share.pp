# Definition winbind::share
#
# This class setups up a config file to be included into smb.conf
#
define winbind::share (
  String        $ensure_setting  = lookup('winbind::share::ensure_setting'),
  Hash          $settings_hash   = lookup('winbind::settings_hash'),
  Array[String] $smb_include_dir = lookup('winbind::smb_includes_dir'),
) {

  file { "${smb_include_dir}/${title}.conf":
    ensure  => $ensure_setting,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('winbind/share.epp', {
      'settings_hash' => $settings_hash,
      'title'         => $title
    }),
    require => File[$smb_include_dir],
    notify  => Service['smb'],
  }
}
