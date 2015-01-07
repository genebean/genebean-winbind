# winbind

This module will configure winbind for joining Active Directory. So far, it is
only tested on CentOS 6 & 7 but that will be expanded some as time goes on.
Tests have not been implemented yet but will be. This module is also designed
with using hiera in mind.

## Paramters

There are a significant number of possible parameters. These correspond directly
to the four configuration files that get edited by this module. Each is prefixed
so that you know which file it effects:

* pam     = /etc/security/pam_winbind.con
* smb     = /etc/samba/smb.conf
* krb5    = /etc/krb5.conf
* oddjobd = /etc/oddjobd.conf.d/oddjobd-mkhomedir.conf

The primary parameters are as follows:

### pam_require_membership_of

If set, this will limit who can log in via winbind

### smb_workgroup

This is the short name of your domain.

### smb_realm

This is the long name of your domain. It is also used in krb5.conf for the
`realms` and `domain_realms` settings.

## License

This is released under the New BSD / BSD-3-Clause license. A copy of the license
can be found in the root of the module.

## Contributing

Pull requests are welcome!
