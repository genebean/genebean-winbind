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

This module will configure winbind for joining Active Directory and is designed
with hiera in mind. It will also, optionally, allow you to configure SMB shares
since `smb.conf` is used for both purposes.


## Setup Requirements

The configuration used in this module requires Samba >= 3.6.
[Bolt][bolt] is required if you want to use the
included task to join machines to your domain.


## Beginning with winbind

### Usage

This module does not join your machine to AD but does provide you a Puppet task
to do so. The reason it is not done during a Puppet run is that we have not
found a secure way to do the joins since they require a privileged account and
its password. Having said that, below is a recommended method of putting this
module to use that limits your manual work to running a single Puppet task with
[Bolt][bolt]. The task can join one or many nodes to the domain in a single run.

#### Recommended setup

1. Include this module in a suitable default location such as a profile that
  includes your base settings. An example of this can be seen in
  [examples/winbind.pp](examples/winbind.pp).
2. Add the defaults for your domain to hiera. An example of this can be
  seen in [examples/common.yaml](examples/common.yaml).
3. Apply the profile to desired nodes.
4. Run `bolt plan run winbind::join_domain domainuser=some-ad-user domainpassword=$ad_password nodes=node1,node2,node3 --user root`
5. Enjoy


#### Alternate joinDomain.sh templates

This module contains scripts for joing mahcines in the Red Hat and SUSE families
to a domain. If you would rather use your own scripts then be sure to add
`winbind::manage_joindomain_script: false` to your common.yaml file. If, on the
other hand, you simply find that the scripts in here could be improved or
expanded then please send us a pull request on GitHub.

#### Configuring SMB shares

The settings above will get you on a domain. If you want to supplement those
with one or more SMB shares you will need the following additional configuration
settings:

1. Add `winbind::enable_sharing : true` to your node's file in hiera
2. Create a share by either placing files with the needed settings in
   `/etc/samba/smb.conf.d/` OR by using a hash. Using a hash is the recommended
   method.

   If you choose to use files, their names will need to be listed in an array
   as part of `winbind::smb_includes_files`

   If you choose to use a hash, you can either put it in a manifest like so:

   ```puppet
   $my_smb_settings_hash = {
     'share1' => {
       'path'      => '/tmp',
       'browsable' => 'yes',
       'read only' => 'yes'
     },
     'share2' => {
       'path'      => '/mnt',
       'browsable' => 'no',
       'read only' => 'yes'
     },
   }

   class { winbind:
     enable_sharing    => true,
     smb_settings_hash => $my_smb_settings_hash,
   }
   ```

   Or if you choose to use hiera the same hash would look like this:

   ```yaml
   ---
   winbind::smb_settings_hash:
     share1:
       path      : '/tmp'
       browsable : 'yes'
       read only : 'yes'
     share2:
       path      : '/mnt'
       browsable : 'no'
       read only : 'yes'
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

`manage_joindomain_script`

Allows disabling the management of `/root/joinDomain.sh`. Defaults to `true`.

`manage_messagebus_service`

Allows disabling the management of the messagebus service. Defaults to `true`.

`manage_oddjob_service`

Allows disabling the management of the oddjobd service. Defaults to `true`.

`package_ensure`

Defines the ensure setting passed to all managed packages. Defaults to `present`.


## Limitations

This module has only been tested on Red Hat 5, CentOS 6 & 7, SLES 11 & 12, and Debian 9 & 10.


## Troubleshooting

On RHEL 5 we found that joining was difficult if just the right things were not
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
* Jason Lavoie (@oasys) - Added Debian support


[bolt]: https://github.com/puppetlabs/bolt
[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-winbind.svg
[gh-link]: https://github.com/genebean/genebean-winbind
[init.pp]: https://github.com/genebean/genebean-winbind/blob/master/manifests/init.pp
[pf-img]: https://img.shields.io/puppetforge/v/genebean/winbind.svg
[pf-link]: https://forge.puppetlabs.com/genebean/winbind
[travis-ci]: https://travis-ci.org/genebean/genebean-winbind
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-winbind/master.svg
