require 'spec_helper'

describe 'winbind' do

  describe 'on Red Hat' do
    let :facts do
      {
        :kernel                    => 'Linux',
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'RedHat',
        :operatingsystemmajrelease => '7',
        :fqdn                      => 'SOMEHOST.ad.example.com'
      }
    end

    # Check that all classes are present
    it { should contain_class('stdlib')}
    it { should contain_class('winbind::params')}
    it { should contain_class('winbind::install')}
    it { should contain_class('winbind::config')}
    it { should contain_class('winbind::service')}

    context 'with domain and login restrictions set' do
      let :facts do
        {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7',
          :fqdn                      => 'SOMEHOST.ad.example.com'
        }
      end

      let :pre_condition do
        "class {'winbind':
          pam_require_membership_of => ['sysadmins', 'iso-scans'],
          smb_realm                 => 'AD.EXAMPLE.COM',
          smb_workgroup             => 'AD',
        }"
      end

      it 'should pass parameters to winbind::config' do
        should contain_class('winbind::config').with(
          'pam_require_membership_of' => '["sysadmins", "iso-scans"]',
          'smb_realm'                 => 'AD.EXAMPLE.COM',
          'smb_workgroup'             => 'AD',
        )
      end

    end

    context 'with package_ensure set to installed' do
      let :facts do
        {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7',
          :fqdn                      => 'SOMEHOST.ad.example.com'
        }
      end

      let :pre_condition do
        "class {'winbind':
          package_ensure => 'installed',
        }"
      end

      it 'should pass parameters to winbind::install' do
        should contain_class('winbind::install').with(
          'package_ensure' => 'installed',
        )
      end
    end

    context 'with service management disabled' do
      let :facts do
        {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7',
          :fqdn                      => 'SOMEHOST.ad.example.com'
        }
      end

      let :pre_condition do
        "class {'winbind':
          manage_messagebus_service => false,
          manage_oddjob_service     => false,
          manage_samba_service      => false,
        }"
      end

      it 'should pass parameters to winbind::service' do
        should contain_class('winbind::service').with(
          'manage_messagebus_service' => false,
          'manage_oddjob_service'     => false,
          'manage_samba_service'      => false,
        )
      end

    end

    context 'with sharing enabled' do
      let :facts do
        {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7',
          :fqdn                      => 'SOMEHOST.ad.example.com'
        }
      end

      let :pre_condition do
        "class {'winbind':
          enable_sharing => true,
        }"
      end

      it 'should pass parameters to winbind::install' do
        should contain_class('winbind::install').with(
          'enable_sharing' => true,
        )
      end

      it 'should pass parameters to winbind::service' do
        should contain_class('winbind::service').with(
          'enable_sharing' => true,
        )
      end

    end

  end

  describe 'on Suse' do
    let :facts do
      {
        :kernel            => 'Linux',
        :osfamily          => 'Suse',
        :operatingsystem   => 'SLES',
        :lsbmajdistrelease => '12',
        :fqdn              => 'SOMEHOST.ad.example.com'
      }
    end

    # Check that all classes are present
    it { should contain_class('stdlib')}
    it { should contain_class('winbind::params')}
    it { should contain_class('winbind::install')}
    it { should contain_class('winbind::config')}
    it { should contain_class('winbind::service')}

    context 'with domain and login restrictions set' do
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
          pam_require_membership_of => ['sysadmins', 'iso-scans'],
          smb_realm                 => 'AD.EXAMPLE.COM',
          smb_workgroup             => 'AD',
        }"
      end

      it 'should pass parameters to winbind::config' do
        should contain_class('winbind::config').with(
          'pam_require_membership_of' => '["sysadmins", "iso-scans"]',
          'smb_realm'                 => 'AD.EXAMPLE.COM',
          'smb_workgroup'             => 'AD',
        )
      end

    end

    context 'with package_ensure set to installed' do
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

      it 'should pass parameters to winbind::install' do
        should contain_class('winbind::install').with(
          'package_ensure' => 'installed',
        )
      end
    end

    context 'with service management disabled' do
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
          manage_messagebus_service => false,
          manage_oddjob_service     => false,
          manage_samba_service      => false,
        }"
      end

      it 'should pass parameters to winbind::service' do
        should contain_class('winbind::service').with(
          'manage_messagebus_service' => false,
          'manage_oddjob_service'     => false,
          'manage_samba_service'      => false,
        )
      end

    end

    context 'with sharing enabled' do
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
          enable_sharing => true,
        }"
      end

      it 'should pass parameters to winbind::install' do
        should contain_class('winbind::install').with(
          'enable_sharing' => true,
        )
      end

      it 'should pass parameters to winbind::service' do
        should contain_class('winbind::service').with(
          'enable_sharing' => true,
        )
      end

    end


  end

end
