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
class winbind::config (
  # lint:ignore:80chars
  $krb5_libdefaults_default_realm    = $::winbind::krb5_libdefaults_default_realm,
  $krb5_libdefaults_dns_lookup_kdc   = $::winbind::krb5_libdefaults_dns_lookup_kdc,
  $krb5_libdefaults_dns_lookup_realm = $::winbind::krb5_libdefaults_dns_lookup_realm,
  $krb5_libdefaults_forwardable      = $::winbind::krb5_libdefaults_forwardable,
  $krb5_libdefaults_renew_lifetime   = $::winbind::krb5_libdefaults_renew_lifetime,
  $krb5_libdefaults_ticket_lifetime  = $::winbind::krb5_libdefaults_ticket_lifetime,
  $krb5_logging_admin_server         = $::winbind::krb5_logging_admin_server,
  $krb5_logging_default              = $::winbind::krb5_logging_default,
  $krb5_logging_kdc                  = $::winbind::krb5_logging_kdc,
  $krb5_realms_admin_server          = $::winbind::krb5_realms_admin_server,
  $krb5_realms_kdc                   = $::winbind::krb5_realms_kdc,
  $manage_joindomain_script          = $::winbind::manage_joindomain_script,
  $manage_samba_service              = $::winbind::manage_samba_service,
  $package_ensure                    = $::winbind::package_ensure,
  $pam_cached_login                  = $::winbind::pam_cached_login,
  $pam_debug                         = $::winbind::pam_debug,
  $pam_debug_state                   = $::winbind::pam_debug_state,
  $pam_krb5_auth                     = $::winbind::pam_krb5_auth,
  $pam_krb5_ccache_type              = $::winbind::pam_krb5_ccache_type,
  $pam_mkhomedir                     = $::winbind::pam_mkhomedir,
  $pam_require_membership_of         = $::winbind::pam_require_membership_of,
  $pam_silent                        = $::winbind::pam_silent,
  $pam_warn_pwd_expire               = $::winbind::pam_warn_pwd_expire,
  $smb_client_use_spnego             = $::winbind::smb_client_use_spnego,
  $smb_cups_options                  = $::winbind::smb_cups_options,
  $smb_disable_spoolss               = $::winbind::smb_disable_spoolss,
  $smb_encrypt_passwords             = $::winbind::smb_encrypt_passwords,
  $smb_idmap_config_backend          = $::winbind::smb_idmap_config_backend,
  $smb_idmap_config_base_rid         = $::winbind::smb_idmap_config_base_rid,
  $smb_idmap_config_range            = $::winbind::smb_idmap_config_range,
  $smb_idmap_config_rangesize        = $::winbind::smb_idmap_config_rangesize,
  $smb_kerberos_method               = $::winbind::smb_kerberos_method,
  $smb_load_printers                 = $::winbind::smb_load_printers,
  $smb_log_file                      = $::winbind::smb_log_file,
  $smb_max_log_size                  = $::winbind::smb_max_log_size,
  $smb_passdb_backend                = $::winbind::smb_passdb_backend,
  $smb_password_server               = $::winbind::smb_password_server,
  $smb_printcap_name                 = $::winbind::smb_printcap_name,
  $smb_printing                      = $::winbind::smb_printing,
  $smb_realm                         = $::winbind::smb_realm,
  $smb_security                      = $::winbind::smb_security,
  $smb_server_string                 = $::winbind::smb_server_string,
  $smb_show_add_printer_wizard       = $::winbind::smb_show_add_printer_wizard,
  $smb_template_homedir              = $::winbind::smb_template_homedir,
  $smb_template_shell                = $::winbind::smb_template_shell,
  $smb_winbind_cache_time            = $::winbind::smb_winbind_cache_time,
  $smb_winbind_enum_groups           = $::winbind::smb_winbind_enum_groups,
  $smb_winbind_enum_users            = $::winbind::smb_winbind_enum_users,
  $smb_winbind_offline_logon         = $::winbind::smb_winbind_offline_logon,
  $smb_winbind_separator             = $::winbind::smb_winbind_separator,
  $smb_winbind_use_default_domain    = $::winbind::smb_winbind_use_default_domain,
  $smb_workgroup                     = $::winbind::smb_workgroup,
  # lint:endignore
  ) {
  if $manage_joindomain_script {
    $joindomain = $::osfamily ? {
      'RedHat' => 'joindomainForRedHat.sh',
      'Suse'   => 'joinDomainForSUSE.sh',
      default  => 'joindomainForRedHat.sh',
    }

    file { '/root/joinDomain.sh':
      ensure => present,
      mode   => '0755',
      source => "puppet:///modules/winbind/${joindomain}",
    }
  }

  file { '/etc/krb5.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('winbind/krb5.conf.erb'),
    notify  => Service['winbind'],
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
