# Sample profile for controlling domainJoin scripts
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

