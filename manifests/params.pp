# Default settings for parameters
class winbind::params {
  $enable_sharing                       = false
  $krb5_admin_server                    = 'FILE:/var/log/kadmind.log'
  $krb5_default                         = 'FILE:/var/log/krb5libs.log'
  $krb5_dns_lookup_kdc                  = true
  $krb5_dns_lookup_realm                = false
  $krb5_forwardable                     = true
  $krb5_kdc                             = 'FILE:/var/log/krb5kdc.log'
  $krb5_renew_lifetime                  = '7d'
  $krb5_ticket_lifetime                 = '24h'
  $manage_messagebus_service            = true
  $manage_oddjob_service                = $::osfamily ? {
    'Suse'  => false,
    default => true,
  }
  $manage_samba_service                 = true
  $oddjobd_homdir_mask                  = '0077'
  $package_ensure                       = 'present'
  $pam_cached_login                     = 'yes'
  $pam_debug                            = 'no'
  $pam_debug_state                      = 'no'
  $pam_krb5_auth                        = 'no'
  # An string is needed here, even if it is an empty one.
  # lint:ignore:empty_string_assignment
  $pam_krb5_ccache_type                 = ''
  # lint:endignore
  $pam_mkhomedir                        = 'no'
  $pam_require_membership_of            = ['',]
  $pam_silent                           = 'no'
  $pam_warn_pwd_expire                  = 14
  $smb_encrypt_passwords                = 'yes'
  $smb_idmap_config_default_backend     = 'autorid'
  $smb_idmap_config_default_range_end   = 19999999
  $smb_idmap_config_default_rangesize   = 1000000
  $smb_idmap_config_default_range_start = 1000000
  $smb_includes_dir                     = '/etc/samba/smb.conf.d'
  $smb_includes_files                   = []
  $smb_log_file                         = '/var/log/samba/%m'
  $smb_log_level                        = 0
  $smb_max_log_size                     = 0
  $smb_printcap_name                    = 'cups'
  $smb_printing                         = 'cups'
  $smb_realm                            = 'EXAMPLE.COM'
  $smb_security                         = 'ads'
  $smb_server_string                    = $::hostname
  $smb_settings_hash                    = undef
  $smb_syslog                           = 0
  $smb_template_homedir                 = '/home/%D/%U'
  $smb_template_shell                   = '/bin/bash'
  $smb_winbind_enum_groups              = 'no'
  $smb_winbind_enum_users               = 'no'
  $smb_winbind_normalize_names          = 'no'
  $smb_winbind_nss_info                 = 'rfc2307'
  $smb_winbind_offline_logon            = true
  $smb_winbind_separator                = '+'
  $smb_winbind_use_default_domain       = true
  $smb_workgroup                        = 'EXAMPLE'

}
