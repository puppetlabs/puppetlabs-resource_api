# Install resource_api module dependencies on a puppet master.

# Every master: master of masters, and if present, compile masters and replica
# needs to be classified with this class before it can compile catalogs for
# device modules that use the resource_api.

# @summary Install dependencies into the puppetserver service and restart
#
# @example
#   include resource_api::install::master
#
# @param [String] api_version A specific release version of Resource API to install
# @param [Type[Resource]] puppetserver_service The name of the puppetserver service to restart

class resource_api::install::master(
  String $api_version = 'latest',
  Type[Resource] $puppetserver_service = $facts['pe_server_version'] ? {
    /./     => Service['pe-puppetserver'],
    default => Service['puppetserver']
  },
) {

  # Since PE and Puppet are bundled together, it is enough to only check for the puppet version here.

  if versioncmp($facts['puppetversion'], '6.0.0') < 0 {
    package { 'Resource API on the puppetserver':
      ensure   => $api_version,
      name     => 'puppet-resource_api',
      provider => puppetserver_gem,
    }

    Package['Resource API on the puppetserver'] ~> $puppetserver_service
  }

}

