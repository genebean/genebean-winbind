require 'spec_helper'

describe 'winbind::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        let :pre_condition do
          "class {'winbind': }"
        end

        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '5'
            it { should contain_package('samba3x-winbind').with_ensure('present') }
            it { should have_package_resource_count(1) }
          else
            it { should contain_package('samba-winbind-clients').with_ensure('present') }
            it { should contain_package('oddjob-mkhomedir').with_ensure('present') }
            it { should have_package_resource_count(2) }
          end
        when 'Suse'
          it { should contain_package('samba-winbind').with_ensure('present') }
          it { should have_package_resource_count(1) }
        else
          it {is_expected.to raise_error(/OS family is not supported/)}
        end # ends case facts[:osfamily]
      end # ends context 'with defaults'

      context 'with package_ensure changed to installed' do
        let :pre_condition do
          "class {'winbind':
            package_ensure => 'installed',
          }"
        end

        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '5'
            it { should contain_package('samba3x-winbind').with_ensure('installed') }
            it { should have_package_resource_count(1) }
          else
            it { should contain_package('samba-winbind-clients').with_ensure('installed') }
            it { should contain_package('oddjob-mkhomedir').with_ensure('installed') }
            it { should have_package_resource_count(2) }
          end
        when 'Suse'
          it { should contain_package('samba-winbind').with_ensure('installed') }
          it { should have_package_resource_count(1) }
        else
          it {is_expected.to raise_error(/OS family is not supported/)}
        end # ends case facts[:osfamily]
      end # ends context 'with package_ensure changed to installed'

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing => true,
          }"
        end

        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '5'
            it { should contain_package('samba3x-winbind').with_ensure('present') }
            it { should contain_package('samba3x').with_ensure('present') }
            it { should have_package_resource_count(2) }
          else
            it { should contain_package('samba-winbind-clients').with_ensure('present') }
            it { should contain_package('oddjob-mkhomedir').with_ensure('present') }
            it { should contain_package('samba').with_ensure('present') }
            it { should have_package_resource_count(3) }
          end
        when 'Suse'
          it { should contain_package('samba-winbind').with_ensure('present') }
          it { should contain_package('samba').with_ensure('present') }
          it { should have_package_resource_count(2) }
        else
          it {is_expected.to raise_error(/OS family is not supported/)}
        end # ends case facts[:osfamily]
      end # ends context 'with sharing enabled'
    end
  end
end
