require 'spec_helper'

describe 'winbind' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      # Check that all classes are present
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('winbind::install')}
      it { is_expected.to contain_class('winbind::config')}
      it { is_expected.to contain_class('winbind::service')}
    end
  end

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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind:' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
          'enable_sharing' => true,
        )
      end

      it 'should pass parameters to winbind:' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
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

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
          'enable_sharing' => true,
        )
      end

      it 'should pass parameters to winbind' do
        should contain_class('winbind').with(
          'enable_sharing' => true,
        )
      end

    end


  end

end
