require 'spec_helper'

describe 'resource_api::server' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with PE' do
        let(:facts) { super().merge(pe_server_version: '5.3.6') }
        let(:pre_cond) { 'service { "pe-puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[pe-puppetserver]') }
      end

      context 'with FOSS' do
        let(:pre_cond) { 'service { "puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[puppetserver]') }
      end

      context 'with a custom install' do
        let(:params) { { puppetserver_service: 'Service["custom puppetserver"]' } }
        let(:pre_cond) { 'service { "custom puppetserver": }' }

        it { is_expected.to compile }
        it { is_expected.to contain_package('Resource API on the puppetserver').with(ensure: :latest) }
        it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[custom puppetserver]') }
      end
    end
  end
end
