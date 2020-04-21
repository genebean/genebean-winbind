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

        it 'manages /root/joinDomain.sh' do
          is_expected.to contain_file('/root/joinDomain.sh')
        end

        it 'makes /root/joinDomain.sh executable' do
          is_expected.to contain_file('/root/joinDomain.sh').with_mode('0755')
        end

        case facts[:os]['family']
        when 'RedHat'
          it 'uses joinDomainForRedHat.sh as source for /root/joinDomain.sh' do
            is_expected.to contain_file('/root/joinDomain.sh').with_source('puppet:///modules/winbind/joinDomainForRedHat.sh')
          end
        when 'Suse'
          it 'uses joinDomainForSUSE.sh as source for /root/joinDomain.sh' do
            is_expected.to contain_file('/root/joinDomain.sh').with_source('puppet:///modules/winbind/joinDomainForSUSE.sh')
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

        it 'sets require_membership_of in pam_winbind.conf' do
          is_expected.to contain_file('/etc/security/pam_winbind.conf').with_content(%r{require_membership_of = sysadmins,iso-scans})
        end

        it 'uses $smb_realm in smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').with_content(%r{realm\s+ = AD.EXAMPLE.COM})
        end

        it 'uses $smb_realm in krb5.conf' do
          is_expected.to contain_file('/etc/krb5.conf').with_content(%r[AD.EXAMPLE.COM = {])
          is_expected.to contain_file('/etc/krb5.conf').with_content(%r{\ \.ad.example.com = AD.EXAMPLE.COM})
          is_expected.to contain_file('/etc/krb5.conf').with_content(%r{\ ad.example.com = AD.EXAMPLE.COM})
        end

        it 'uses $smb_workgroup in smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').with_content(%r{workgroup\s+ = AD})
        end

        case facts[:os]['family']
        when 'RedHat'
          it 'manages oddjobd-mkhomedir.conf' do
            is_expected.to contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(%r{This file is managed by Puppet})
            is_expected.to contain_file('/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf').with_content(%r{<oddjobconfig>})
          end
        end
      end

      context 'with winbind separator removed' do
        let :pre_condition do
          "class {'winbind':
            smb_winbind_separator => '',
          }"
        end
    
        it 'does not include winbind separator smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').without_content(/winbind\sseparator\s+ = \+/)
        end
      end
    
      context 'with default winbind separator' do
        let :pre_condition do
          "include winbind"
        end
    
        it 'includes default winbind separator in smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').with_content(/winbind\sseparator\s+ = \+/)
        end
      end

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing     => true,
            smb_includes_files => [ 'share1', 'share2', ],
          }"
        end

        it 'creates the directory smb.conf.d' do
          is_expected.to contain_file('/etc/samba/smb.conf.d').with_ensure('directory')
        end

        it 'includes share1.conf in smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').with_content(%r{include\s+ = \/etc\/samba\/smb.conf.d\/share1.conf})
        end

        it 'includes share2.conf in smb.conf' do
          is_expected.to contain_file('/etc/samba/smb.conf').with_content(%r{include\s+ = \/etc\/samba\/smb.conf.d\/share2.conf})
        end
      end
    end
  end
end
