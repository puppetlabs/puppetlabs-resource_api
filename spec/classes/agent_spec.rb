require 'spec_helper'

describe 'resource_api::agent' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_package('Resource API on the puppet AIO').with(name: 'puppet-resource_api', ensure: :latest) }
    end
  end
end
