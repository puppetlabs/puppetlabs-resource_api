require 'spec_helper'

describe 'resource_api::server' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with PE < 2018.2' do
        let(:facts) { super().merge(puppetversion: '5.5.5', pe_server_version: '5.3.6') }
        let(:pre_cond) { 'service { "pe-puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[pe-puppetserver]') }
      end

      context 'with PE >= 2018.2' do
        let(:facts) { super().merge(puppetversion: '6.0.0', pe_server_version: '6.0.0') }

        it { is_expected.to compile }
        it { is_expected.not_to contain_package('Resource API on the puppetserver') }
      end

      context 'with FOSS puppet < 6' do
        let(:facts) { super().merge(puppetversion: '5.5.5') }
        let(:pre_cond) { 'service { "puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[puppetserver]') }
      end

      context 'with FOSS puppet >= 6' do
        let(:facts) { super().merge(puppetversion: '6.0.0') }

        it { is_expected.to compile }
        it { is_expected.not_to contain_package('Resource API on the puppetserver') }
      end

      context 'with a custom install' do
        let(:facts) { super().merge(puppetversion: '5.5.5') }
        let(:params) { { puppetserver_service: ResourceReference.new('Service["custom puppetserver"]') } }
        let(:pre_cond) { 'service { "custom puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[custom puppetserver]') }
      end

      context 'when requesting a specific API version' do
        let(:facts) { super().merge(puppetversion: '5.5.5') }
        let(:params) { { api_version: '1.5' } }
        let(:pre_cond) { 'service { "puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: '1.5') }
      end
    end
  end
end
