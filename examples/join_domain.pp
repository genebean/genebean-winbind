class profiles::join_domain {
  # Used on selected OS only
  case $::kernel {
    Linux   : {
      include ::winbind

      $joindomain = $::osfamily ? {
        'RedHat' => 'joindomainForRedHat.sh',
        'Suse'   => 'joinDomainForSUSE.sh',
        default  => 'joindomainForRedHat.sh',
      }

      file { '/root/joinDomain.sh':
        ensure => present,
        mode   => '0755',
        source => "puppet:///modules/profiles/${joindomain}",
      }

    } # end Linux

    Windows : {
    }

    default : {
      fail("${::operatingsystem} is not supported.")
    }

  } # end case $::kernel
}
