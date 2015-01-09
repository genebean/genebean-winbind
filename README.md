[![Puppet Forge][pf-img]][pf-link] [![GitHub tag][gh-tag-img]][gh-link]

# winbind

#### Table of Contents

1. [Overview](#overview)
2. [Setup requirements](#setup-requirements)
3. [Beginning with winbind](#beginning-with-winbind)
4. [Limitations](#limitations)
5. [License](#license)
6. [Contributing](#contributing)

## Overview

This module will configure winbind for joining Active Directory. Tests have not
been implemented yet but will be. This module is also designed with using hiera
in mind.

## Setup Requirements

The conifguration used in this module requires Samba >= 3.6.

## Beginning with winbind

There are a significant number of possible parameters. These correspond directly
to the four configuration files that get edited by this module. Each is prefixed
so that you know which file it effects:

* pam     = /etc/security/pam_winbind.con
* smb     = /etc/samba/smb.conf
* krb5    = /etc/krb5.conf
* oddjobd = /etc/oddjobd.conf.d/oddjobd-mkhomedir.conf

The primary parameters are as follows:

`pam_require_membership_of`

If set, this will limit who can log in via winbind

`smb_workgroup`

This is the short name of your domain.

`smb_realm`

This is the long name of your domain. It is also used in krb5.conf for the
`realms` and `domain_realms` settings.

## Limitations

This module has only been tested on CentOS 6 & 7 but that will be expanded
some as time goes on.

## License

This is released under the New BSD / BSD-3-Clause license. A copy of the license
can be found in the root of the module.

## Contributing

Pull requests are welcome!

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-winbind.svg
[gh-link]: https://github.com/genebean/genebean-winbind
[pf-img]: https://img.shields.io/puppetforge/v/genebean/winbind.svg
[pf-link]: https://forge.puppetlabs.com/genebean/winbind
