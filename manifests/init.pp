# Class: winbind
#
# This module manages winbind
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class winbind (
  Boolean              $enable_sharing,
  String               $krb5_admin_server,
  String               $krb5_default,
  Boolean              $krb5_dns_lookup_kdc,
  Boolean              $krb5_dns_lookup_realm,
  Boolean              $krb5_forwardable,
  String               $krb5_kdc,
  String               $krb5_renew_lifetime,
  String               $krb5_ticket_lifetime,
  Boolean              $manage_messagebus_service,
  Boolean              $manage_oddjob_service,
  Boolean              $manage_samba_service,
  String               $oddjobd_homdir_mask,
  String               $package_ensure,
  String               $pam_cached_login,
  String               $pam_debug_state,
  String               $pam_debug,
  String               $pam_krb5_auth,
  String               $pam_krb5_ccache_type,
  String               $pam_mkhomedir,
  Array[String]        $pam_require_membership_of,
  String               $pam_silent,
  Numeric              $pam_warn_pwd_expire,
  String               $smb_encrypt_passwords,
  String               $smb_idmap_config_default_backend,
  Numeric              $smb_idmap_config_default_range_end,
  Numeric              $smb_idmap_config_default_rangesize,
  Numeric              $smb_idmap_config_default_range_start,
  Stdlib::Absolutepath $smb_includes_dir,
  Array[String]        $smb_includes_files,
  String               $smb_log_file,
  Numeric              $smb_log_level,
  Numeric              $smb_max_log_size,
  String               $smb_printcap_name,
  String               $smb_printing,
  String               $smb_realm,
  String               $smb_security,
  String               $smb_server_string,
  Optional[Hash]       $smb_settings_hash,
  Numeric              $smb_syslog,
  String               $smb_template_homedir,
  String               $smb_template_shell,
  String               $smb_winbind_enum_groups,
  String               $smb_winbind_enum_users,
  String               $smb_winbind_normalize_names,
  String               $smb_winbind_nss_info,
  Boolean              $smb_winbind_offline_logon,
  String               $smb_winbind_separator,
  Boolean              $smb_winbind_use_default_domain,
  String               $smb_workgroup,
  ) {

    contain ::winbind::install
    contain ::winbind::config
    contain ::winbind::service

  Class['::winbind::install']
  -> Class['::winbind::config']
  -> Class['::winbind::service']

}
