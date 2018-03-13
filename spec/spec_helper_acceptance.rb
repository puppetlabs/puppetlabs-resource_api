require 'beaker-rspec' if ENV['BEAKER_TESTMODE'] != 'local'
require 'beaker/module_install_helper'
require 'beaker/puppet_install_helper'
require 'beaker/testmode_switcher/dsl'

def beaker_opts
  @env = if ENV['BEAKER_TESTMODE'] != 'local'
           { debug: true, trace: true }
         else
           {}
         end
end

RSpec.configure do |c|
  c.before :suite do
    unless ENV['BEAKER_TESTMODE'] == 'local'
      unless ENV['BEAKER_provision'] == 'no'
        run_puppet_install_helper
        install_module_on(hosts)
        install_module_dependencies_on(hosts)
      end
    end
  end
end
