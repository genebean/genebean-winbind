# Configures settings associated with using winbind for joining Active Directory
class winbind::install (
  $pam_debug                            = $::winbind::params::pam_debug,
  $pam_debug_state                      = $::winbind::params::pam_debug_state,
  $pam_cached_login                     = $::winbind::params::pam_cached_login,
  $pam_krb5_auth                        = $::winbind::params::pam_krb5_auth,
  $pam_krb5_ccache_type                 = $::winbind::params::pam_krb5_ccache_type,
  $pam_require_membership_of            = $::winbind::params::pam_require_membership_of,
  $pam_warn_pwd_expire                  = $::winbind::params::pam_warn_pwd_expire,
  $pam_silent                           = $::winbind::params::pam_silent,
  $pam_mkhomedir                        = $::winbind::params::pam_mkhomedir,
  $smb_workgroup                        = $::winbind::params::smb_workgroup,
  $smb_realm                            = $::winbind::params::smb_realm,
  $smb_encrypt_passwords                = $::winbind::params::smb_encrypt_passwords,
  $smb_log_level                        = $::winbind::params::smb_log_level,
  $smb_syslog                           = $::winbind::params::smb_syslog,
  $smb_server_string                    = $::winbind::params::smb_server_string,
  $smb_security                         = $::winbind::params::smb_security,
  $smb_log_file                         = $::winbind::params::smb_log_file,
  $smb_max_log_size                     = $::winbind::params::smb_max_log_size,
  $smb_printcap_name                    = $::winbind::params::smb_printcap_name,
  $smb_printing                         = $::winbind::params::smb_printing,
  $smb_winbind_enum_users               = $::winbind::params::smb_winbind_enum_users,
  $smb_winbind_enum_groups              = $::winbind::params::smb_winbind_enum_groups,
  $smb_winbind_use_default_domain       = $::winbind::params::smb_winbind_use_default_domain,
  $smb_winbind_nss_info                 = $::winbind::params::smb_winbind_nss_info,
  $smb_winbind_normalize_names          = $::winbind::params::smb_winbind_normalize_names,
  $smb_winbind_offline_logon            = $::winbind::params::smb_winbind_offline_logon,
  $smb_winbind_separator                = $::winbind::params::smb_winbind_separator,
  $smb_template_homedir                 = $::winbind::params::smb_template_homedir,
  $smb_template_shell                   = $::winbind::params::smb_template_shell,
  $smb_idmap_config_default_backend     = $::winbind::params::smb_idmap_config_default_backend,
  $smb_idmap_config_default_range_start = $::winbind::params::smb_idmap_config_default_range_start,
  $smb_idmap_config_default_range_end   = $::winbind::params::smb_idmap_config_default_range_end,
  $smb_idmap_config_default_rangesize   = $::winbind::params::smb_idmap_config_default_rangesize,
  $krb5_default                         = $::winbind::params::krb5_default,
  $krb5_kdc                             = $::winbind::params::krb5_kdc,
  $krb5_admin_server                    = $::winbind::params::krb5_admin_server,
  $krb5_dns_lookup_realm                = $::winbind::params::krb5_dns_lookup_realm,
  $krb5_dns_lookup_kdc                  = $::winbind::params::krb5_dns_lookup_kdc,
  $krb5_ticket_lifetime                 = $::winbind::params::krb5_ticket_lifetime,
  $krb5_renew_lifetime                  = $::winbind::params::krb5_renew_lifetime,
  $krb5_forwardable                     = $::winbind::params::krb5_forwardable,
  $oddjobd_homdir_mask                  = $::winbind::params::oddjobd_homdir_mask,
  ) inherits ::winbind::params {
    file { '/etc/krb5.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['samba-winbind-clients'],
      content => template('winbind/krb5.conf.erb'),
      notify  => Service['winbind'],
      
    }
    
    file { '/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['oddjob-mkhomedir'],
      content => template('winbind/oddjobd-mkhomedir.conf.erb'),
      notify  => Service[['oddjobd', 'winbind', ]],
      
    }
    
    file { '/etc/samba/smb.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['samba-winbind-clients'],
      content => template('winbind/smb.conf.erb'),
      notify  => Service['winbind'],
      
    }
    
    file { '/etc/security/pam_winbind.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['samba-winbind-clients'],
      content => template('winbind/pam_winbind.conf.erb'),
      notify  => Service['winbind'],
      
    }

}
