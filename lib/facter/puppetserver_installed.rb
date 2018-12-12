# As per: lib/puppet/provider/package/puppetserver_gem.rb ...
#
#   commands :puppetservercmd => "/opt/puppetlabs/bin/puppetserver"

Facter.add('puppetserver_installed') do
  setcode do
    File.file?('/opt/puppetlabs/bin/puppetserver')
  end
end
