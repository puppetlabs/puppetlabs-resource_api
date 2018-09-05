require 'spec_helper'

describe 'resource_api::agent' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with puppet < 6' do
        let(:facts) { super().merge(puppetversion: '5.5.5') }

        context 'with defaults' do
          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppet AIO').with(name: 'puppet-resource_api', ensure: :latest) }
        end

        context 'when requesting a specific API version' do
          let(:params) { { api_version: '1.5' } }

          it { is_expected.to compile }
          it { is_expected.to contain_package('Resource API on the puppet AIO').with(name: 'puppet-resource_api', ensure: '1.5') }
        end
      end

      context 'with puppet >= 6' do
        let(:facts) { super().merge(puppetversion: '6.0.0') }

        context 'with defaults' do
          it { is_expected.to compile }
          it { is_expected.not_to contain_package('Resource API on the puppet AIO') }
        end
      end
    end
  end
end
