require 'spec_helper_acceptance'

# allow @result to be used to cache expensive one-off agent runs
# rubocop:disable RSpec/InstanceVariable
RSpec.context 'when applying resource_api::agent' do
  before(:all) do
    @manifest = 'include resource_api::agent'
    @result = apply_manifest_on(default, @manifest, beaker_opts)
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
      @result = apply_manifest_on(default, @manifest, beaker_opts)
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
      @result = apply_manifest_on(default, @manifest, beaker_opts)
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
