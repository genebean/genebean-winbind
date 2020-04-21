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
          it { is_expected.to contain_package('samba-winbind-clients').with_ensure('present') }
          it { is_expected.to contain_package('oddjob-mkhomedir').with_ensure('present') }
          it { is_expected.to have_package_resource_count(2) }
        when 'Suse'
          it { is_expected.to contain_package('samba-winbind').with_ensure('present') }
          it { is_expected.to have_package_resource_count(1) }
        else
          it { is_expected.to raise_error(%r{OS family is not supported}) }
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
          it { is_expected.to contain_package('samba-winbind-clients').with_ensure('installed') }
          it { is_expected.to contain_package('oddjob-mkhomedir').with_ensure('installed') }
          it { is_expected.to have_package_resource_count(2) }
        when 'Suse'
          it { is_expected.to contain_package('samba-winbind').with_ensure('installed') }
          it { is_expected.to have_package_resource_count(1) }
        else
          it { is_expected.to raise_error(%r{OS family is not supported}) }
        end # ends case facts[:osfamily]
      end # ends context 'with package_ensure changed to installed'

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing => true,
          }"
        end

        # rubocop:disable RSpec/RepeatedExample
        case facts[:os]['family']
        when 'RedHat'
          it { is_expected.to contain_package('samba-winbind-clients').with_ensure('present') }
          it { is_expected.to contain_package('oddjob-mkhomedir').with_ensure('present') }
          it { is_expected.to contain_package('samba').with_ensure('present') }
          it { is_expected.to have_package_resource_count(3) }
        when 'Suse'
          it { is_expected.to contain_package('samba-winbind').with_ensure('present') }
          it { is_expected.to contain_package('samba').with_ensure('present') }
          it { is_expected.to have_package_resource_count(2) }
        else
          it { is_expected.to raise_error(%r{OS family is not supported}) }
        end # ends case facts[:osfamily]
        # rubocop:ensable RSpec/RepeatedExample
      end # ends context 'with sharing enabled'
    end
  end
end
