# Install resource_api module dependencies on a puppet agent.

# A proxy agent needs to be classified with this class before it can use
# device modules that use the resource_api.

# @summary Install dependencies into the puppet agent
#
# @example
#   include resource_api::install::agent
#
# @param [String] api_version A specific release version of Resource API to install

class resource_api::install::agent(
  String $api_version = 'latest',
) {

  if versioncmp($facts['puppetversion'], '6.0.0') < 0 {
    package { 'Resource API on the puppet AIO':
      ensure   => $api_version,
      name     => 'puppet-resource_api',
      provider => puppet_gem,
    }
  }

}

