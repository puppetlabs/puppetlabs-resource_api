require 'spec_helper_acceptance'

# allow @result to be used to cache expensive one-off agent runs
# rubocop:disable RSpec/InstanceVariable
RSpec.context 'when applying resource_api::server', unless: ENV['PUPPET_INSTALL_TYPE'] == 'agent' do
  before(:all) do
    @manifest = <<MANIFEST
include resource_api::agent, resource_api::server

# cloned from https://github.com/puppetlabs/puppetlabs-puppet_enterprise/blob/a82d3adafcf1dfd13f1c338032f325d80fa58eda/manifests/trapperkeeper/pe_service.pp#L10-L17
service { 'pe-puppetserver':
    ensure     => running,
    hasrestart => true,
    restart    => "service pe-puppetserver reload",
}
MANIFEST

    @result = apply_manifest_on(master, @manifest, beaker_opts)
  end

  it 'runs with changes and without errors' do
    skip 'on puppet 6, no changes expected' unless puppet6?
    expect(@result.exit_code).to eq 2
  end

  it 'runs with no changes and without errors' do
    skip 'not on puppet 6, changes expected' if puppet6?
    expect(@result.exit_code).to eq 0
  end

  it 'does not show errors' do
    expect(@result.stderr).not_to match %r{error}i
  end

  context 'when applying a second time' do
    before(:all) do
      @result = apply_manifest_on(master, @manifest, beaker_opts)
    end

    it 'runs without changes or errors' do
      expect(@result.exit_code).to eq 0
    end

    it 'does not show errors' do
      expect(@result.stderr).not_to match %r{error}i
    end
  end

  context 'when trying to load the resource_api from the puppet command' do
    before(:all) do
      @manifest = 'resource_api_test { "baz": ensure => present }'
      @result = apply_manifest_on(master, @manifest, beaker_opts)
    end

    it 'runs with changes and without errors' do
      expect(@result.exit_code).to eq 2
    end

    it 'outputs the expected message' do
      expect(@result.stdout).to match %r{Creating 'baz'}
    end

    it 'does not show errors' do
      expect(@result.stderr).not_to match %r{error}i
    end
  end

  context 'when running a full agent run' do
    require 'master_manipulator'
    include MasterManipulator::Site

    before(:all) do
      @manifest = 'resource_api_test { "baz": ensure => present }'

      environment_base_path = on(master, puppet('config', 'print', 'environmentpath')).stdout.rstrip
      prod_env_site_pp_path = File.join(environment_base_path, 'production', 'manifests', 'site.pp')
      site_pp = create_site_pp(master, manifest: @manifest)
      inject_site_pp(master, prod_env_site_pp_path, site_pp)

      @result = on(default, puppet('agent', '--test', '--environment production', '--detailed-exitcodes'), beaker_opts)
    end

    it 'runs with changes and without errors' do
      expect(@result.exit_code).to eq 2
    end

    it 'outputs the expected message' do
      expect(@result.stdout).to match %r{Creating 'baz'}
    end

    it 'does not show errors' do
      expect(@result.stderr).not_to match %r{error}i
    end
  end
end
