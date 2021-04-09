require 'spec_helper'

describe 'winbind::service' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        let :pre_condition do
          "class {'winbind': }"
        end

        # rubocop:disable RSpec/RepeatedExample
        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '7'
            it { is_expected.to contain_service('oddjobd').with_ensure('running') }
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to have_service_resource_count(2) }
          else
            it { is_expected.to contain_service('messagebus').with_ensure('running') }
            it { is_expected.to contain_service('oddjobd').with_ensure('running') }
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to have_service_resource_count(3) }
          end
        when 'Suse'
          it { is_expected.to contain_service('winbind').with_ensure('running') }
          it { is_expected.to have_service_resource_count(1) }
        when 'Debian'
          it { is_expected.to contain_service('winbind').with_ensure('running') }
          it { is_expected.to have_service_resource_count(1) }
        else
          it { is_expected.to raise_error(%r{OS family is not supported}) }
        end # ends case facts[:osfamily]
        # rubocop:enable RSpec/RepeatedExample
      end # ends context 'with defaults'

      context 'with manage_oddjob_service => false' do
        let :pre_condition do
          "class {'winbind':
            manage_oddjob_service => false,
          }"
        end

        # rubocop:disable RSpec/RepeatedExample
        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '7'
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to have_service_resource_count(1) }
          else
            it { is_expected.to contain_service('messagebus').with_ensure('running') }
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to have_service_resource_count(2) }
          end
        end # ends case facts[:osfamily]
        # rubocop:enable RSpec/RepeatedExample
      end # ends context 'with manage_oddjob_service => false'

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing => true,
          }"
        end

        # rubocop:disable RSpec/RepeatedExample
        case facts[:os]['family']
        when 'RedHat'
          case facts[:os]['release']['major']
          when '7'
            it { is_expected.to contain_service('oddjobd').with_ensure('running') }
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to contain_service('smb').with_ensure('running') }
            it { is_expected.to have_service_resource_count(3) }
          else
            it { is_expected.to contain_service('messagebus').with_ensure('running') }
            it { is_expected.to contain_service('oddjobd').with_ensure('running') }
            it { is_expected.to contain_service('winbind').with_ensure('running') }
            it { is_expected.to contain_service('smb').with_ensure('running') }
            it { is_expected.to have_service_resource_count(4) }
          end
        when 'Suse'
          it { is_expected.to contain_service('winbind').with_ensure('running') }
          it { is_expected.to contain_service('smb').with_ensure('running') }
          it { is_expected.to have_service_resource_count(2) }
        when 'Debian'
          it { is_expected.to contain_service('winbind').with_ensure('running') }
          it { is_expected.to contain_service('smbd').with_ensure('running') }
          it { is_expected.to have_service_resource_count(2) }
        else
          it { is_expected.to raise_error(%r{OS family is not supported}) }
        end # ends case facts[:osfamily]
        # rubocop:enable RSpec/RepeatedExample
      end # ends context 'with sharing enabled'
    end
  end
end
