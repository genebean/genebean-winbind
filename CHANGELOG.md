[![GitHub tag][gh-tag-img]][gh-link]

## 2017-08-06 - Release 1.5.3  
- First run at using modulesync
- Stopped testing against Puppet 3
- Started testing against Puppet 5

## 1.5.2 2017-08-01  
- Updated the CHANGELOG

## 1.5.1 2017-08-01  
- Addressed issue #12 where the `winbind` service would fail to start if the
  samba-winbind package is updated to v4.6 via Puppet before kerberos packages
  are updated by changing `package_ensure` to `present` by default.

## 1.5.0 2016-08-16  
- Added additional puppet-lint tests
- Fixed 3 issues identified by new puppet-lint tests

## 1.4.1 2016-08-13  
- Fixed typo in README

## 1.4.0 2016-08-13  
- Merged in PR #3 to help future proof version comparisons in `service.pp`

## 1.3.0 2016-08-13  
- Added support for configuring SMB shares since we already manage `smb.conf`

## 1.2.0 2016-08-12  
- Added a test on Travis CI that includes 3.x and the future parser

## 1.1.1 2016-08-12  
- Fixed issue where the Puppet 4.x build on Travis CI failed due to a gem's
  version being incorrect

## 1.1.0 2016-08-12  
- Added support for SUSE (thanks Jake Spain)
- This release was pulled from the Forge due to errors fixed in 1.1.1

## 1.0.0 2015-09-10  
- Added support for toggling service management and
  overriding the package ensure setting (thanks Adam Stephens)
- Added a full test suite and Travis-CI support
- Updated manifests for Puppet 4 support

## 0.4.0 2015-05-04  
- Updated to better support RHEL 5
- Cleaned up parameters

## 0.3.2  
- Puppet Forge didn't like having Samba listed in the metadata.json file...

## 0.3.1  
- Added a change log

## 0.3.0  
- Updated README

## 0.2.1  
- Worked with Puppet Labs and changed my username on Puppet Forge to all lower
  case

## 0.2.0  
- Initial working version

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-winbind.svg?label=newest%20tag
[gh-link]: https://github.com/genebean/genebean-winbind
