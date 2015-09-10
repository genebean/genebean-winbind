require 'spec_helper'

describe 'winbind::config' do

  describe 'with domain and login restrictions set' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat',
        :fqdn            => 'SOMEHOST.ad.example.com'
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
      should contain_file('/etc/samba/smb.conf').with_content(/realm                          = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_realm in krb5.conf' do
      should contain_file('/etc/krb5.conf').with_content(/AD.EXAMPLE.COM = {/)
      should contain_file('/etc/krb5.conf').with_content(/\ \.ad.example.com = AD.EXAMPLE.COM/)
      should contain_file('/etc/krb5.conf').with_content(/\ ad.example.com = AD.EXAMPLE.COM/)
    end

    it 'should use $smb_workgroup in smb.conf' do
      should contain_file('/etc/samba/smb.conf').with_content(/workgroup                      = AD/)
    end

  end

end
