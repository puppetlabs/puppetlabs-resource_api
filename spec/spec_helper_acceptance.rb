require 'beaker-pe'
require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/module_install_helper'
require 'beaker/puppet_install_helper'

def beaker_opts
  { debug: false, trace: true, expect_failures: true, acceptable_exit_codes: (0...256) }
  # { expect_failures: true, acceptable_exit_codes: (0...256) }
end

# determine whether or not we're on puppet 6, which has the gem integrated
# if the gem is integrated, we do not want to install over it
def puppet6?
  @__puppet6 ||= Gem::Version.new(fact_on(default, 'puppetversion')) >= Gem::Version.new('6.0.0')
end

RSpec.configure do |c|
  c.before :suite do
    unless ENV['BEAKER_provision'] == 'no'
      run_puppet_install_helper
      configure_type_defaults_on(hosts)
      install_module_on(hosts_as('master'))
      install_module_on(hosts_as('default'))
      install_module_dependencies_on(hosts)
    end
  end
end
