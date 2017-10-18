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

        case facts[:osfamily]
        when 'RedHat'
          case facts[:operatingsystemmajrelease]
          when '7'
            it { should contain_service('oddjobd').with_ensure('running') }
            it { should contain_service('winbind').with_ensure('running') }
            it { should have_service_resource_count(2) }
          else
            it { should contain_service('messagebus').with_ensure('running') }
            it { should contain_service('oddjobd').with_ensure('running') }
            it { should contain_service('winbind').with_ensure('running') }
            it { should have_service_resource_count(3) }
          end
        when 'Suse'
          it { should contain_service('winbind').with_ensure('running') }
          it { should have_service_resource_count(1) }
        else
          it {is_expected.to raise_error(/OS family is not supported/)}
        end # ends case facts[:osfamily]
      end # ends context 'with defaults'

      context 'with manage_oddjob_service => false' do
        let :pre_condition do
          "class {'winbind':
            manage_oddjob_service => false,
          }"
        end

        case facts[:osfamily]
        when 'RedHat'
          case facts[:operatingsystemmajrelease]
          when '7'
            it { should contain_service('winbind').with_ensure('running') }
            it { should have_service_resource_count(1) }
          else
            it { should contain_service('messagebus').with_ensure('running') }
            it { should contain_service('winbind').with_ensure('running') }
            it { should have_service_resource_count(2) }
          end
        end # ends case facts[:osfamily]
      end # ends context 'with manage_oddjob_service => false'

      context 'with sharing enabled' do
        let :pre_condition do
          "class {'winbind':
            enable_sharing => true,
          }"
        end

        case facts[:osfamily]
        when 'RedHat'
          case facts[:operatingsystemmajrelease]
          when '7'
            it { should contain_service('oddjobd').with_ensure('running') }
            it { should contain_service('winbind').with_ensure('running') }
            it { should contain_service('smb').with_ensure('running') }
            it { should have_service_resource_count(3) }
          else
            it { should contain_service('messagebus').with_ensure('running') }
            it { should contain_service('oddjobd').with_ensure('running') }
            it { should contain_service('winbind').with_ensure('running') }
            it { should contain_service('smb').with_ensure('running') }
            it { should have_service_resource_count(4) }
          end
        when 'Suse'
          it { should contain_service('winbind').with_ensure('running') }
          it { should contain_service('smb').with_ensure('running') }
          it { should have_service_resource_count(2) }
        else
          it {is_expected.to raise_error(/OS family is not supported/)}
        end # ends case facts[:osfamily]
      end # ends context 'with sharing enabled'
    end
  end
end
