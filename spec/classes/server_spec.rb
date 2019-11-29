require 'spec_helper'

describe 'resource_api::server' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'on Puppet6 or later', if: Gem::Version.new(os_facts[:puppetversion]) >= Gem::Version.new('6.0.0') do
        context 'when running PE' do
          let(:facts) { super().merge(pe_server_version: '6.0.0') }

          it { is_expected.to compile }
          it { is_expected.not_to contain_package('Resource API on the puppetserver') }
        end
        context 'when running FOSS' do
          it { is_expected.to compile }
          it { is_expected.not_to contain_package('Resource API on the puppetserver') }
        end
      end

      context 'on Puppet5', if: Gem::Version.new(os_facts[:puppetversion]) < Gem::Version.new('6.0.0') do
        context 'when running PE' do
          let(:facts) { super().merge(pe_server_version: 'some_version') }
          let(:pre_cond) { 'service { "pe-puppetserver": }' }

          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
          it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[pe-puppetserver]') }
        end

        context 'when running FOSS' do
          let(:pre_cond) { 'service { "puppetserver": }' }

          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
          it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[puppetserver]') }
        end

        context 'with a custom install' do
          let(:params) { { puppetserver_service: ResourceReference.new('Service["custom puppetserver"]') } }
          let(:pre_cond) { 'service { "custom puppetserver": }' }

          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: :latest) }
          it { is_expected.to contain_package('Resource API on the puppetserver').that_notifies('Service[custom puppetserver]') }
        end

        context 'when requesting a specific API version' do
          let(:params) { { api_version: '1.5' } }
          let(:pre_cond) { 'service { "puppetserver": }' }

          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppetserver').with(name: 'puppet-resource_api', ensure: '1.5') }
        end
      end
    end
  end
end
