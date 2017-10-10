# Sample profile for controlling domainJoin scripts
class profiles::join_domain {
  # Used on selected OS only
  case $::kernel {
    'Linux'   : {
      include ::winbind
    } # end Linux

    'Windows' : {
    }

    default : {
      fail("${::operatingsystem} is not supported.")
    }

  } # end case $::kernel
}
