require 'spec_helper'

describe 'winbind' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:node) { 'SOMEHOST.ad.example.com' }

      # Check that all classes are present
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('winbind::install') }
      it { is_expected.to contain_class('winbind::config') }
      it { is_expected.to contain_class('winbind::service') }

      context 'with domain and login restrictions set' do
        let(:params) do
          {
            'pam_require_membership_of' => ['sysadmins', 'iso-scans'],
            'smb_realm'                 => 'AD.EXAMPLE.COM',
            'smb_workgroup'             => 'AD',
          }
        end

        it 'passes parameters to winbind' do
          is_expected.to contain_class('winbind').with(
            'pam_require_membership_of' => '["sysadmins", "iso-scans"]',
            'smb_realm'                 => 'AD.EXAMPLE.COM',
            'smb_workgroup'             => 'AD',
          )
        end
      end

      context 'with package_ensure set to installed' do
        let(:params) do
          {
            'package_ensure' => 'installed',
          }
        end

        it 'passes parameters to winbind' do
          is_expected.to contain_class('winbind').with(
            'package_ensure' => 'installed',
          )
        end
      end

      context 'with service management disabled' do
        let(:params) do
          {
            'manage_messagebus_service' => false,
            'manage_oddjob_service'     => false,
            'manage_samba_service'      => false,
          }
        end

        it 'passes parameters to winbind' do
          is_expected.to contain_class('winbind').with(
            'manage_messagebus_service' => false,
            'manage_oddjob_service'     => false,
            'manage_samba_service'      => false,
          )
        end
      end

      context 'with sharing enabled' do
        let(:params) do
          {
            'enable_sharing' => true,
          }
        end

        it 'passes parameters to winbind' do
          is_expected.to contain_class('winbind').with(
            'enable_sharing' => true,
          )
        end
      end
    end
  end
end
