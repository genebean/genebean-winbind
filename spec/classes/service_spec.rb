require 'spec_helper'

describe 'winbind::service' do

  context 'on Red Hat 5' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '5'
      }
    end

    context 'with defaults' do
      let :pre_condition do
        "class {'winbind': }"
      end

      # Make sure the right services are managed.
      it { should contain_service('messagebus').with_ensure('running') }
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should have_service_resource_count(3) }
    end

    context 'with sharing enabled' do
      let :pre_condition do
        "class {'winbind':
          enable_sharing => true,
        }"
      end

      # Make sure the right services are managed.
      it { should contain_service('messagebus').with_ensure('running') }
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should contain_service('smb').with_ensure('running') }
      it { should have_service_resource_count(4) }
    end

  end

  context 'on Red Hat 6' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '6'
      }
    end

    context 'with defaults' do
      let :pre_condition do
        "class {'winbind': }"
      end

      # Make sure the right services are managed.
      it { should contain_service('messagebus').with_ensure('running') }
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should have_service_resource_count(3) }
    end

    context 'with sharing enabled' do
      let :pre_condition do
        "class {'winbind':
          enable_sharing => true,
        }"
      end

      # Make sure the right services are managed.
      it { should contain_service('messagebus').with_ensure('running') }
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should contain_service('smb').with_ensure('running') }
      it { should have_service_resource_count(4) }
    end

  end

  context 'on Red Hat 7' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7'
      }
    end

    context 'with defaults' do
      let :pre_condition do
        "class {'winbind': }"
      end

      # Make sure the right services are managed.
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should have_service_resource_count(2) }
    end

    context 'with sharing enabled' do
      let :pre_condition do
        "class {'winbind':
          enable_sharing => true,
        }"
      end

      # Make sure the right services are managed.
      it { should contain_service('oddjobd').with_ensure('running') }
      it { should contain_service('winbind').with_ensure('running') }
      it { should contain_service('smb').with_ensure('running') }
      it { should have_service_resource_count(3) }
    end

    context 'with manage_oddjob_service => false' do
      let :pre_condition do
        "class {'winbind':
          manage_oddjob_service => false,
        }"
      end

      # Make sure the right services are managed.
      it { should contain_service('winbind').with_ensure('running') }
      it { should have_service_resource_count(1) }
    end

  end

  context 'on SLES 12' do
    let :facts do
      {
        :kernel            => 'Linux',
        :osfamily          => 'Suse',
        :operatingsystem   => 'SLES',
        :lsbmajdistrelease => '12',
      }
    end

    context 'with defaults' do
      let :pre_condition do
        "class {'winbind': }"
      end

      # Make sure the right services are managed.
      it { should contain_service('winbind').with_ensure('running') }
      it { should have_service_resource_count(1) }
    end

    context 'with sharing enabled' do
      let :pre_condition do
        "class {'winbind':
          enable_sharing => true,
        }"
      end

      # Make sure the right services are managed.
      it { should contain_service('winbind').with_ensure('running') }
      it { should contain_service('smb').with_ensure('running') }
      it { should have_service_resource_count(2) }
    end

  end

end
