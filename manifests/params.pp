# Default settings for parameters
class winbind::params {
  # Kerberos
  $krb5_libdefaults_default_realm    = 'DE.LAN'
  $krb5_libdefaults_dns_lookup_kdc   = true
  $krb5_libdefaults_dns_lookup_realm = false
  $krb5_libdefaults_forwardable      = true
  $krb5_libdefaults_renew_lifetime   = '7d'
  $krb5_libdefaults_ticket_lifetime  = '24h'
  $krb5_logging_admin_server         = 'FILE:/var/log/kadmind.log'
  $krb5_logging_default              = 'FILE:/var/log/krb5libs.log'
  $krb5_logging_kdc                  = 'FILE:/var/log/krb5kdc.log'
  $krb5_realms_admin_server          = 's-ad-01:749'
  $krb5_realms_kdc                   = ['s-ad-01:88','s-ad-02:88']
  # Services & Packages
  $manage_joindomain_script          = false
  $manage_samba_service              = true
  #$manage_oddjob_service                = $::osfamily ? {
  #  'Suse'  => false,
  #  default => true,
  $package_ensure                    = 'present'
  # PAM
  $pam_cached_login                  = 'no'
  $pam_debug                         = 'no'
  $pam_debug_state                   = 'no'
  $pam_krb5_auth                     = 'no'
  # An is needed here, even if it is an empty one.
  # lint:ignore:empty_string_assignment
  $pam_krb5_ccache_type              = ''
  # lint:endignore
  $pam_mkhomedir                     = 'no'
  $pam_require_membership_of         = ['',]
  $pam_silent                        = 'no'
  $pam_warn_pwd_expire               = 14
  # SMB
  $smb_client_use_spnego             = 'yes'
  $smb_cups_options                  = 'raw'
  $smb_disable_spoolss               = 'yes'
  $smb_encrypt_passwords             = 'yes'
  $smb_idmap_config_backend          = 'rid'
  $smb_idmap_config_base_rid         = 0
  $smb_idmap_config_range            = '1 - 49999'
  $smb_idmap_config_rangesize        = 1000000
  $smb_kerberos_method               = 'secrets only'
  $smb_load_printers                 = 'no'
  $smb_log_file                      = '/var/log/samba/log.%m'
  $smb_max_log_size                  = 50
  $smb_passdb_backend                = 'tdbsam'
  $smb_password_server               = 's-ad-01 s-ad-02'
  $smb_printcap_name                 = '/dev/nul'
  $smb_printing                      = 'bsd'
  $smb_realm                         = 'DE.LAN'
  $smb_security                      = 'ads'
  $smb_server_string                 = 'Samba Server Version %v'
  $smb_show_add_printer_wizard       = 'no'
  $smb_template_homedir              = '/home/%D/%U'
  $smb_template_shell                = '/bin/bash'
  $smb_winbind_cache_time            = 30
  $smb_winbind_enum_groups           = 'no'
  $smb_winbind_enum_users            = 'no'
  $smb_winbind_offline_logon         = false
  $smb_winbind_separator             = '/'
  $smb_winbind_use_default_domain    = true
  $smb_workgroup                     = 'DE'
}
