require 'spec_helper'

describe 'winbind::install' do

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

    # Make sure package will be installed.
    it { should contain_package('samba3x-winbind').with_ensure('latest') }
    it { should have_package_resource_count(1) }

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

    # Make sure package will be installed.
    it { should contain_package('samba-winbind-clients').with_ensure('latest') }
    it { should contain_package('oddjob-mkhomedir').with_ensure('latest') }
    it { should have_package_resource_count(2) }

  end

  context 'on Red Hat 7 with package_ensure set to installed' do
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
        package_ensure => 'installed',
      }"
    end

    # Make sure package will be installed.
    it { should contain_package('samba-winbind-clients').with_ensure('installed') }
    it { should contain_package('oddjob-mkhomedir').with_ensure('installed') }
    it { should have_package_resource_count(2) }

  end

  context 'on SLES 12 with defaults' do
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
      "class {'winbind': }"
    end

    # Make sure package will be installed.
    it { should contain_package('samba-winbind').with_ensure('latest') }
    it { should have_package_resource_count(1) }

  end

  context 'on SLES 12 with package_ensure set to installed' do
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
        package_ensure => 'installed',
      }"
    end

    # Make sure package will be installed.
    it { should contain_package('samba-winbind').with_ensure('installed') }
    it { should have_package_resource_count(1) }

  end

end
