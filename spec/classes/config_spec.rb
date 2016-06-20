require 'spec_helper'

describe 'winbind::config' do

  describe 'with domain and login restrictions set on RedHat' do
    let :facts do
      {
        :kernel                    => 'Linux',
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'RedHat',
        :operatingsystemmajrelease => '7',
        :fqdn                      => 'SOMEHOST.ad.example.com'
      }
    end

    let :pre_condition do
      "class {'winbind':
        pam_require_membership_of => ['sysadmins', 'iso-scans'],
        smb_realm                 => 'AD.EXAMPLE.COM',
        smb_workgroup             => 'AD',
      }"
    end

    it 'should set require_membership_of in pam_winbind.conf' do
      should contain_file('/etc/security/pam_winbind.conf').with_content(/require_membership_of = sysadmins,iso-scans/)
    end

    it 'should use $smb_realm in smb.conf' do
      should contain_file('/etc/samba/smb.conf').with_content(/realm\s+ = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_realm in krb5.conf' do
      should contain_file('/etc/krb5.conf').with_content(/AD.EXAMPLE.COM = {/)
      should contain_file('/etc/krb5.conf').with_content(/\ \.ad.example.com = AD.EXAMPLE.COM/)
      should contain_file('/etc/krb5.conf').with_content(/\ ad.example.com = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_workgroup in smb.conf' do
      should contain_file('/etc/samba/smb.conf').with_content(/workgroup\s+ = AD/)
    end

    it 'should manage oddjobd-mkhomedir.conf' do
      should contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(/This file is managed by Puppet/)
      should contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(/<oddjobconfig>/)
    end

  end

  describe 'with domain and login restrictions set on Suse' do
    let :facts do
      {
        :kernel            => 'Linux',
        :osfamily          => 'Suse',
        :operatingsystem   => 'SLES',
        :lsbmajdistrelease => '12',
        :fqdn              => 'SOMEHOST.ad.example.com'
      }
    end

    let :pre_condition do
      "class {'winbind':
        pam_require_membership_of => ['sysadmins', 'iso-scans'],
        smb_realm                 => 'AD.EXAMPLE.COM',
        smb_workgroup             => 'AD',
      }"
    end

    it 'should set require_membership_of in pam_winbind.conf' do
      should contain_file('/etc/security/pam_winbind.conf').with_content(/require_membership_of = sysadmins,iso-scans/)
    end

    it 'should use $smb_realm in smb.conf' do
      should contain_file('/etc/samba/smb.conf').with_content(/realm\s+ = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_realm in krb5.conf' do
      should contain_file('/etc/krb5.conf').with_content(/AD.EXAMPLE.COM = {/)
      should contain_file('/etc/krb5.conf').with_content(/\ \.ad.example.com = AD.EXAMPLE.COM/)
      should contain_file('/etc/krb5.conf').with_content(/\ ad.example.com = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_workgroup in smb.conf' do
      should contain_file('/etc/samba/smb.conf').with_content(/workgroup\s+ = AD/)
    end

  end

end
