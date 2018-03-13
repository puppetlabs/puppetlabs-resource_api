require 'spec_helper_acceptance'

# allow @result to be used to cache expensive one-off agent runs
# rubocop:disable RSpec/InstanceVariable
RSpec.context 'when applying resource_api::agent' do
  let(:manifest) { 'include resource_api::agent' }

  before(:all) do
    @result = execute_manifest(manifest, beaker_opts)
  end

  it 'runs with changes and without errors' do
    expect(@result.exit_code).to eq 2
  end

  context 'when applying a second time' do
    before(:all) do
      @result = execute_manifest(manifest, beaker_opts)
    end
    it 'runs without changes or errors' do
      expect(@result.exit_code).to eq 0
    end
  end

  it 'can load the resource_api gem in a puppet context' do
    test_manifest = 'warning(inline_template("<%= require \\"puppet/resource_api\\"; puts \\"SUCCESS\\" %>"))'
    if Beaker::TestmodeSwitcher.mode == 'agent' do
      # verify success on the agent, not on the master
      result = apply_manifest_on(default, test_manifest, beaker_opts)
    else
      result = apply_manifest_on(default, test_manifest, beaker_opts)
    end
  end
end
