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
  # lint:ignore:80chars
  $krb5_admin_server                    = $::winbind::params::krb5_admin_server,
  $krb5_default                         = $::winbind::params::krb5_default,
  $krb5_dns_lookup_kdc                  = $::winbind::params::krb5_dns_lookup_kdc,
  $krb5_dns_lookup_realm                = $::winbind::params::krb5_dns_lookup_realm,
  $krb5_forwardable                     = $::winbind::params::krb5_forwardable,
  $krb5_kdc                             = $::winbind::params::krb5_kdc,
  $krb5_renew_lifetime                  = $::winbind::params::krb5_renew_lifetime,
  $krb5_ticket_lifetime                 = $::winbind::params::krb5_ticket_lifetime,
  $manage_messagebus_service            = $::winbind::params::manage_messagebus_service,
  $manage_oddjob_service                = $::winbind::params::manage_oddjob_service,
  $oddjobd_homdir_mask                  = $::winbind::params::oddjobd_homdir_mask,
  $package_ensure                       = $::winbind::params::package_ensure,
  $pam_cached_login                     = $::winbind::params::pam_cached_login,
  $pam_debug_state                      = $::winbind::params::pam_debug_state,
  $pam_debug                            = $::winbind::params::pam_debug,
  $pam_krb5_auth                        = $::winbind::params::pam_krb5_auth,
  $pam_krb5_ccache_type                 = $::winbind::params::pam_krb5_ccache_type,
  $pam_mkhomedir                        = $::winbind::params::pam_mkhomedir,
  $pam_require_membership_of            = $::winbind::params::pam_require_membership_of,
  $pam_silent                           = $::winbind::params::pam_silent,
  $pam_warn_pwd_expire                  = $::winbind::params::pam_warn_pwd_expire,
  $smb_encrypt_passwords                = $::winbind::params::smb_encrypt_passwords,
  $smb_idmap_config_default_backend     = $::winbind::params::smb_idmap_config_default_backend,
  $smb_idmap_config_default_range_end   = $::winbind::params::smb_idmap_config_default_range_end,
  $smb_idmap_config_default_rangesize   = $::winbind::params::smb_idmap_config_default_rangesize,
  $smb_idmap_config_default_range_start = $::winbind::params::smb_idmap_config_default_range_start,
  $smb_log_file                         = $::winbind::params::smb_log_file,
  $smb_log_level                        = $::winbind::params::smb_log_level,
  $smb_max_log_size                     = $::winbind::params::smb_max_log_size,
  $smb_printcap_name                    = $::winbind::params::smb_printcap_name,
  $smb_printing                         = $::winbind::params::smb_printing,
  $smb_realm                            = $::winbind::params::smb_realm,
  $smb_security                         = $::winbind::params::smb_security,
  $smb_server_string                    = $::winbind::params::smb_server_string,
  $smb_syslog                           = $::winbind::params::smb_syslog,
  $smb_template_homedir                 = $::winbind::params::smb_template_homedir,
  $smb_template_shell                   = $::winbind::params::smb_template_shell,
  $smb_winbind_enum_groups              = $::winbind::params::smb_winbind_enum_groups,
  $smb_winbind_enum_users               = $::winbind::params::smb_winbind_enum_users,
  $smb_winbind_normalize_names          = $::winbind::params::smb_winbind_normalize_names,
  $smb_winbind_nss_info                 = $::winbind::params::smb_winbind_nss_info,
  $smb_winbind_offline_logon            = $::winbind::params::smb_winbind_offline_logon,
  $smb_winbind_separator                = $::winbind::params::smb_winbind_separator,
  $smb_winbind_use_default_domain       = $::winbind::params::smb_winbind_use_default_domain,
  $smb_workgroup                        = $::winbind::params::smb_workgroup,
  # lint:endignore
  ) inherits ::winbind::params {
  # validate parameters
  include stdlib

  # strings
  validate_string($pam_debug)
  validate_string($pam_debug_state)
  validate_string($pam_cached_login)
  validate_string($pam_krb5_auth)
  validate_string($pam_krb5_ccache_type)
  validate_string($pam_silent)
  validate_string($pam_mkhomedir)
  validate_string($smb_workgroup)
  validate_string($smb_realm)
  validate_string($smb_encrypt_passwords)
  validate_string($smb_server_string)
  validate_string($smb_security)
  validate_string($smb_log_file)
  validate_string($smb_printcap_name)
  validate_string($smb_printing)
  validate_string($smb_winbind_enum_users)
  validate_string($smb_winbind_enum_groups)
  validate_string($smb_winbind_nss_info)
  validate_string($smb_winbind_normalize_names)
  validate_string($smb_winbind_separator)
  validate_string($smb_template_homedir)
  validate_string($smb_template_shell)
  validate_string($smb_idmap_config_default_backend)
  validate_string($krb5_default)
  validate_string($krb5_kdc)
  validate_string($krb5_admin_server)
  validate_string($krb5_ticket_lifetime)
  validate_string($krb5_renew_lifetime)
  validate_string($oddjobd_homdir_mask)

  # arrays
  validate_array($pam_require_membership_of)

  # numbers
  if ( !is_numeric($pam_warn_pwd_expire) ) {
    fail('pam_warn_pwd_expire must be a number')
  }

  if ( !is_numeric($smb_log_level) ) {
    fail('smb_log_level must be a number')
  }

  if ( !is_numeric($smb_syslog) ) {
    fail('smb_syslog must be a number')
  }

  if ( !is_numeric($smb_max_log_size) ) {
    fail('smb_max_log_size must be a number')
  }

  if ( !is_numeric($smb_idmap_config_default_range_start) ) {
    fail('smb_idmap_config_default_range_start must be a number')
  }

  if ( !is_numeric($smb_idmap_config_default_range_end) ) {
    fail('smb_idmap_config_default_range_end must be a number')
  }

  if ( !is_numeric($smb_idmap_config_default_rangesize) ) {
    fail('smb_idmap_config_default_rangesize must be a number')
  }


  # booleans
  if ( !is_bool($smb_winbind_use_default_domain) ) {
    fail('smb_winbind_use_default_domain must be a true or false')
  }

  if ( !is_bool($smb_winbind_offline_logon) ) {
    fail('smb_winbind_offline_logon must be a true or false')
  }

  if ( !is_bool($krb5_dns_lookup_realm) ) {
    fail('krb5_dns_lookup_realm must be a true or false')
  }

  if ( !is_bool($krb5_dns_lookup_kdc) ) {
    fail('krb5_dns_lookup_kdc must be a true or false')
  }

  if ( !is_bool($krb5_forwardable) ) {
    fail('krb5_forwardable must be a true or false')
  }
  validate_bool($manage_oddjob_service)
  validate_bool($manage_messagebus_service)


  # use the install -> config -> service model
  anchor {'::winbind::start': } ->
  class { '::winbind::install': } ->
  class { '::winbind::config': } ->
  class { '::winbind::service': } ->
  anchor {'::winbind::end': }

}
