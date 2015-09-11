require 'spec_helper'

describe 'winbind::service' do

  context 'on Red Hat 5 with defaults' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '5'
      }
    end

    let :pre_condition do
      "class {'winbind': }"
    end

    # Make sure the right services are managed.
    it { should contain_service('messagebus').with_ensure('running') }
    it { should contain_service('oddjobd').with_ensure('running') }
    it { should contain_service('winbind').with_ensure('running') }
    it { should have_service_resource_count(3) }

  end

  context 'on Red Hat 6 with defaults' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '6'
      }
    end

    let :pre_condition do
      "class {'winbind': }"
    end

    # Make sure the right services are managed.
    it { should contain_service('messagebus').with_ensure('running') }
    it { should contain_service('oddjobd').with_ensure('running') }
    it { should contain_service('winbind').with_ensure('running') }
    it { should have_service_resource_count(3) }

  end

  context 'on Red Hat 7 with defaults' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7'
      }
    end

    let :pre_condition do
      "class {'winbind': }"
    end

    # Make sure the right services are managed.
    it { should contain_service('oddjobd').with_ensure('running') }
    it { should contain_service('winbind').with_ensure('running') }
    it { should have_service_resource_count(2) }

  end

  context 'on Red Hat 7 with manage_oddjob_service => false' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7'
      }
    end

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
