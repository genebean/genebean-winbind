require 'spec_helper'

describe 'winbind::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:node) { 'SOMEHOST.ad.example.com' }

      context 'with defaults' do
        let :pre_condition do
          "class {'winbind': }"
        end

        it 'should manage /root/joinDomain.sh' do
          should contain_file('/root/joinDomain.sh')
        end

        it 'should make /root/joinDomain.sh executable' do
          should contain_file('/root/joinDomain.sh').with_mode('0755')
        end

        case facts[:osfamily]
        when 'RedHat'
          it 'should use joinDomainForRedHat.sh as source for /root/joinDomain.sh' do
            should contain_file('/root/joinDomain.sh').with_source('puppet:///modules/winbind/joinDomainForRedHat.sh')
          end
        when 'Suse'
          it 'should use joinDomainForSUSE.sh as source for /root/joinDomain.sh' do
            should contain_file('/root/joinDomain.sh').with_source('puppet:///modules/winbind/joinDomainForSUSE.sh')
          end
        end # ends case facts[:osfamily]
      end # ends context 'with defaults'

      context 'with domain and login restrictions' do
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

        case facts[:osfamily]
        when 'RedHat'
          it 'should manage oddjobd-mkhomedir.conf' do
            should contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(/This file is managed by Puppet/)
            should contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(/<oddjobconfig>/)
          end
        end

      end

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing     => true,
            smb_includes_files => [ 'share1', 'share2', ],
          }"
        end

        it 'should create the directory smb.conf.d' do
          should contain_file('/etc/samba/smb.conf.d').with_ensure('directory')
        end

        it 'should include share1.conf in smb.conf' do
          should contain_file('/etc/samba/smb.conf').with_content(/include\s+ = \/etc\/samba\/smb.conf.d\/share1.conf/)
        end

        it 'should include share2.conf in smb.conf' do
          should contain_file('/etc/samba/smb.conf').with_content(/include\s+ = \/etc\/samba\/smb.conf.d\/share2.conf/)
        end

      end
    end
  end
end
