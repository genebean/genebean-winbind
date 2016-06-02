# Configures settings associated with using winbind to join Active Directory
class winbind::config (
  # lint:ignore:80chars
  $krb5_admin_server                    = $::winbind::krb5_admin_server,
  $krb5_default                         = $::winbind::krb5_default,
  $krb5_dns_lookup_kdc                  = $::winbind::krb5_dns_lookup_kdc,
  $krb5_dns_lookup_realm                = $::winbind::krb5_dns_lookup_realm,
  $krb5_forwardable                     = $::winbind::krb5_forwardable,
  $krb5_kdc                             = $::winbind::krb5_kdc,
  $krb5_renew_lifetime                  = $::winbind::krb5_renew_lifetime,
  $krb5_ticket_lifetime                 = $::winbind::krb5_ticket_lifetime,
  $oddjobd_homdir_mask                  = $::winbind::oddjobd_homdir_mask,
  $pam_cached_login                     = $::winbind::pam_cached_login,
  $pam_debug_state                      = $::winbind::pam_debug_state,
  $pam_debug                            = $::winbind::pam_debug,
  $pam_krb5_auth                        = $::winbind::pam_krb5_auth,
  $pam_krb5_ccache_type                 = $::winbind::pam_krb5_ccache_type,
  $pam_mkhomedir                        = $::winbind::pam_mkhomedir,
  $pam_require_membership_of            = $::winbind::pam_require_membership_of,
  $pam_silent                           = $::winbind::pam_silent,
  $pam_warn_pwd_expire                  = $::winbind::pam_warn_pwd_expire,
  $smb_encrypt_passwords                = $::winbind::smb_encrypt_passwords,
  $smb_idmap_config_default_backend     = $::winbind::smb_idmap_config_default_backend,
  $smb_idmap_config_default_range_end   = $::winbind::smb_idmap_config_default_range_end,
  $smb_idmap_config_default_rangesize   = $::winbind::smb_idmap_config_default_rangesize,
  $smb_idmap_config_default_range_start = $::winbind::smb_idmap_config_default_range_start,
  $smb_log_file                         = $::winbind::smb_log_file,
  $smb_log_level                        = $::winbind::smb_log_level,
  $smb_max_log_size                     = $::winbind::smb_max_log_size,
  $smb_printcap_name                    = $::winbind::smb_printcap_name,
  $smb_printing                         = $::winbind::smb_printing,
  $smb_realm                            = $::winbind::smb_realm,
  $smb_security                         = $::winbind::smb_security,
  $smb_server_string                    = $::winbind::smb_server_string,
  $smb_syslog                           = $::winbind::smb_syslog,
  $smb_template_homedir                 = $::winbind::smb_template_homedir,
  $smb_template_shell                   = $::winbind::smb_template_shell,
  $smb_winbind_enum_groups              = $::winbind::smb_winbind_enum_groups,
  $smb_winbind_enum_users               = $::winbind::smb_winbind_enum_users,
  $smb_winbind_normalize_names          = $::winbind::smb_winbind_normalize_names,
  $smb_winbind_nss_info                 = $::winbind::smb_winbind_nss_info,
  $smb_winbind_offline_logon            = $::winbind::smb_winbind_offline_logon,
  $smb_winbind_separator                = $::winbind::smb_winbind_separator,
  $smb_winbind_use_default_domain       = $::winbind::smb_winbind_use_default_domain,
  $smb_workgroup                        = $::winbind::smb_workgroup,
  # lint:endignore
  ){
  file { '/etc/krb5.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/krb5.conf.erb'),
    notify  => Service['winbind'],
  }

  file { '/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/oddjobd-mkhomedir.conf.erb'),
    notify  => Service[['oddjobd', 'winbind',]],
  }

  file { '/etc/samba/smb.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/smb.conf.erb'),
    notify  => Service['winbind'],
  }

  file { '/etc/security/pam_winbind.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/pam_winbind.conf.erb'),
    notify  => Service['winbind'],
  }

}
