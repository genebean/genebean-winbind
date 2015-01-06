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
  $pam_debug                 = 'no',
  $pam_debug_state           = 'no',
  $pam_cached_login          = 'yes',
  $pam_krb5_auth             = 'no',
  $pam_krb5_ccache_type      = '',
  $pam_require_membership_of = ['',],
  $pam_warn_pwd_expire       = '14',
  $pam_silent                = 'no',
  $pam_mkhomedir             = 'no',) {
  # validate parameters
  include stdlib

  # strings
  validate_string($pam_debug)
  validate_string($pam_debug_state)
  validate_string($pam_cached_login)
  validate_string($pam_krb5_auth)
  validate_string($pam_krb5_ccache_type)
  validate_string($pam_warn_pwd_expire)
  validate_string($pam_silent)
  validate_string($pam_mkhomedir)

  # arrays
  validate_array($pam_require_membership_of)
}
