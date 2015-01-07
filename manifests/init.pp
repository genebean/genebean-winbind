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
  $pam_debug                            = 'no',
  $pam_debug_state                      = 'no',
  $pam_cached_login                     = 'yes',
  $pam_krb5_auth                        = 'no',
  $pam_krb5_ccache_type                 = '',
  $pam_require_membership_of            = ['',],
  $pam_warn_pwd_expire                  = 14,
  $pam_silent                           = 'no',
  $pam_mkhomedir                        = 'no',
  $smb_workgroup                        = 'EXAMPLE',
  $smb_realm                            = 'EXAMPLE.COM',
  $smb_encrypt_passwords                = 'yes',
  $smb_log_level                        = 0,
  $smb_syslog                           = 0,
  $smb_server_string                    = $::hostname,
  $smb_security                         = 'ads',
  $smb_log_file                         = '/var/log/samba/%m',
  $smb_max_log_size                     = 0,
  $smb_printcap_name                    = 'cups',
  $smb_printing                         = 'cups',
  $smb_winbind_enum_users               = 'no',
  $smb_winbind_enum_groups              = 'no',
  $smb_winbind_use_default_domain       = true,
  $smb_winbind_nss_info                 = 'rfc2307',
  $smb_winbind_normalize_names          = 'no',
  $smb_winbind_offline_logon            = true,
  $smb_winbind_separator                = '+',
  $smb_template_homedir                 = '/home/%D/%U',
  $smb_template_shell                   = '/bin/bash',
  $smb_idmap_config_default_backend     = 'autorid',
  $smb_idmap_config_default_range_start = 1000000,
  $smb_idmap_config_default_range_end   = 19999999,
  $smb_idmap_config_default_rangesize   = 1000000,
  $krb5_default                         = 'FILE:/var/log/krb5libs.log',
  $krb5_kdc                             = 'FILE:/var/log/krb5kdc.log',
  $krb5_admin_server                    = 'FILE:/var/log/kadmind.log',
  $krb5_dns_lookup_realm                = false,
  $krb5_dns_lookup_kdc                  = true,
  $krb5_ticket_lifetime                 = '24h',
  $krb5_renew_lifetime                  = '7d',
  $krb5_forwardable                     = true,
  ) {
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

  # arrays
  validate_array($pam_require_membership_of)

  # numbers
  is_numeric($pam_warn_pwd_expire)
  is_numeric($smb_log_level)
  is_numeric($smb_syslog)
  is_numeric($smb_max_log_size)
  is_numeric($smb_idmap_config_default_range_start)
  is_numeric($smb_idmap_config_default_range_end)
  is_numeric($smb_idmap_config_default_rangesize)

  # booleans
  is_bool($smb_winbind_use_default_domain)
  is_bool($smb_winbind_offline_logon)
  is_bool($krb5_dns_lookup_realm)
  is_bool($krb5_dns_lookup_kdc)
  is_bool($krb5_forwardable)

}
