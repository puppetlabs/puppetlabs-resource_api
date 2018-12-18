# resource_api::agent
#
# Install dependencies onto the agent
#
# @summary This class will install the Resource API gem onto the agent
#
# @example  Declaring the class
#   include resource_api::agent
#
# @param [String] api_version A specific release version of Resource API to install
#
# Deprecated by resource_api::install::agent

class resource_api::agent(String $api_version = 'latest') {
  if versioncmp($facts['puppetversion'], '6.0.0') < 0 {
    package { 'Resource API on the puppet AIO':
      ensure   => $api_version,
      name     => 'puppet-resource_api',
      provider => puppet_gem,
    }
  }
}
