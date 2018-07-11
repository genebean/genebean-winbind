class winbind (
  # lint:ignore:80chars
  Array   $pam_require_membership_of         = $::winbind::params::pam_require_membership_of,
  Array   $krb5_realms_kdc                   = $::winbind::params::krb5_realms_kdc,
  String   $smb_password_server               = $::winbind::params::smb_password_server,
  Boolean $krb5_libdefaults_dns_lookup_kdc   = $::winbind::params::krb5_libdefaults_dns_lookup_kdc,
  Boolean $krb5_libdefaults_dns_lookup_realm = $::winbind::params::krb5_libdefaults_dns_lookup_realm,
  Boolean $krb5_libdefaults_forwardable      = $::winbind::params::krb5_libdefaults_forwardable,
  Boolean $manage_joindomain_script          = $::winbind::params::manage_joindomain_script,
  Boolean $manage_samba_service              = $::winbind::params::manage_samba_service,
  Boolean $smb_winbind_offline_logon         = $::winbind::params::smb_winbind_offline_logon,
  Boolean $smb_winbind_use_default_domain    = $::winbind::params::smb_winbind_use_default_domain,
  Numeric $pam_warn_pwd_expire               = $::winbind::params::pam_warn_pwd_expire,
  Numeric $smb_idmap_config_base_rid         = $::winbind::params::smb_idmap_config_base_rid,
  Numeric $smb_idmap_config_rangesize        = $::winbind::params::smb_idmap_config_rangesize,
  Numeric $smb_max_log_size                  = $::winbind::params::smb_max_log_size,
  Numeric $smb_winbind_cache_time            = $::winbind::params::smb_winbind_cache_time,
  String  $krb5_libdefaults_default_realm    = $::winbind::params::krb5_libdefaults_default_realm,
  String  $krb5_libdefaults_renew_lifetime   = $::winbind::params::krb5_libdefaults_renew_lifetime,
  String  $krb5_libdefaults_ticket_lifetime  = $::winbind::params::krb5_libdefaults_ticket_lifetime,
  String  $krb5_logging_admin_server         = $::winbind::params::krb5_logging_admin_server,
  String  $krb5_logging_default              = $::winbind::params::krb5_logging_default,
  String  $krb5_logging_kdc                  = $::winbind::params::krb5_logging_kdc,
  String  $krb5_realms_admin_server          = $::winbind::params::krb5_realms_admin_server,
  String  $package_ensure                    = $::winbind::params::package_ensure,
  String  $pam_cached_login                  = $::winbind::params::pam_cached_login,
  String  $pam_debug                         = $::winbind::params::pam_debug,
  String  $pam_debug_state                   = $::winbind::params::pam_debug_state,
  String  $pam_krb5_auth                     = $::winbind::params::pam_krb5_auth,
  String  $pam_krb5_ccache_type              = $::winbind::params::pam_krb5_ccache_type,
  String  $pam_mkhomedir                     = $::winbind::params::pam_mkhomedir,
  String  $pam_silent                        = $::winbind::params::pam_silent,
  String  $smb_client_use_spnego             = $::winbind::params::smb_client_use_spnego,
  String  $smb_cups_options                  = $::winbind::params::smb_cups_options,
  String  $smb_disable_spoolss               = $::winbind::params::smb_disable_spoolss,
  String  $smb_encrypt_passwords             = $::winbind::params::smb_encrypt_passwords,
  String  $smb_idmap_config_backend          = $::winbind::params::smb_idmap_config_backend,
  String  $smb_idmap_config_range            = $::winbind::params::smb_idmap_config_range,
  String  $smb_kerberos_method               = $::winbind::params::smb_kerberos_method,
  String  $smb_load_printers                 = $::winbind::params::smb_load_printers,
  String  $smb_log_file                      = $::winbind::params::smb_log_file,
  String  $smb_passdb_backend                = $::winbind::params::smb_passdb_backend,
  String  $smb_printcap_name                 = $::winbind::params::smb_printcap_name,
  String  $smb_printing                      = $::winbind::params::smb_printing,
  String  $smb_realm                         = $::winbind::params::smb_realm,
  String  $smb_security                      = $::winbind::params::smb_security,
  String  $smb_server_string                 = $::winbind::params::smb_server_string,
  String  $smb_show_add_printer_wizard       = $::winbind::params::smb_show_add_printer_wizard,
  String  $smb_template_homedir              = $::winbind::params::smb_template_homedir,
  String  $smb_template_shell                = $::winbind::params::smb_template_shell,
  String  $smb_winbind_enum_groups           = $::winbind::params::smb_winbind_enum_groups,
  String  $smb_winbind_enum_users            = $::winbind::params::smb_winbind_enum_users,
  String  $smb_winbind_separator             = $::winbind::params::smb_winbind_separator,
  String  $smb_workgroup                     = $::winbind::params::smb_workgroup,
  # lint:endignore
  ) inherits ::winbind::params {
  # validate parameters
  #include ::stdlib

  # use the install -> config -> service model
  anchor {'::winbind::start': }
  -> class { '::winbind::install': }
  -> class { '::winbind::config': }
  -> class { '::winbind::service': }
  -> anchor {'::winbind::end': }

}
