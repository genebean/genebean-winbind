[![Build Status][travis-img-master]][travis-ci]
[![Puppet Forge][pf-img]][pf-link]
[![GitHub tag][gh-tag-img]][gh-link]

# winbind

#### Table of Contents

1. [Overview](#overview)
2. [Setup requirements](#setup-requirements)
3. [Beginning with winbind](#beginning-with-winbind)
4. [Limitations](#limitations)
5. [Troubleshooting](#troubleshooting)
6. [License](#license)
7. [Contributing](#contributing)


## Overview

This module will configure winbind for joining Active Directory. This module is
also designed with using hiera in mind.


## Setup Requirements

The configuration used in this module requires Samba >= 3.6.


## Beginning with winbind

### Usage

This module DOES NOT join your machine to AD. This is because I have not found
a secure way to do the joins since it requires a privileged account and its
password as part of the join. Once you have run this module at least once you
can join your domain by executing the following pair of commands:

```bash
# On Red Hat
net ads join -U yourADuserName
authconfig --enablemkhomedir --enablewinbind --enablewinbindauth --update

# on Suse
pam-config --add --winbind --mkhomedir --mkhomedir-umask=0077
net ads join -U yourADuserName
```


### Parameters

There is a parameter that corresponds directly to each setting in the four
configuration files that get edited by this module. Each is prefixed
so that you know which file it effects:

* pam     = /etc/security/pam_winbind.con
* smb     = /etc/samba/smb.conf
* krb5    = /etc/krb5.conf
* oddjobd = /etc/oddjobd.conf.d/oddjobd-mkhomedir.conf

The full list of parameters is listed at the top of the [`init.pp`][init.pp] file.
A fully functional setup should be attainable by providing values for the
following three parameters:

`pam_require_membership_of`

If set, this will limit who can log in via winbind

`smb_workgroup`

This is the short name of your domain.

`smb_realm`

This is the long name of your domain. It is also used in krb5.conf for the
`realms` and `domain_realms` settings.

#### Additional Parameters

`manage_messagebus_service`

Allows disabling the management of the messagebus service. Defaults to `true`.

`manage_oddjob_service`

Allows disabling the management of the oddjobd service. Defaults to `true`.

`package_ensure`

Defines the ensure setting passed to all managed packages. Defaults to `latest`.


## Limitations

This module has only been tested on Red Hat 5, CentOS 6 & 7, and SLES 11 & 12.


## Troubleshooting

On RHEL 5 I found that joining was difficult if just the right things were not
in `/etc/hosts`. In particular, I got errors that my DNS name had to match the
domain I was joining. I resolved this issue by making a host entry like this:

```bash
# this should all be on a single line
127.0.0.1 server.example.com server.ad.example.com server localhost
localhost.localdomain  localhost4 localhost4.localdomain4

```

This entry is maintained via a host resource defined elsewhere in my Puppet setup.


## License

This is released under the New BSD / BSD-3-Clause license. A copy of the license
can be found in the root of the module.


## Contributing

Pull requests are welcome!


## Contributors

* Adam Stephens (@adamcstephens) - Added support for toggling service management
  and overriding the package ensure setting
* Jake Spain (@thespain) - Added support for SLES 11 & 12


[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-winbind.svg
[gh-link]: https://github.com/genebean/genebean-winbind
[init.pp]: https://github.com/genebean/genebean-winbind/blob/master/manifests/init.pp
[pf-img]: https://img.shields.io/puppetforge/v/genebean/winbind.svg
[pf-link]: https://forge.puppetlabs.com/genebean/winbind
[travis-ci]: https://travis-ci.org/genebean/genebean-winbind
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-winbind/master.svg
