# resource_api::server
#
# Install dependencies onto the server
#
# @summary  This class will install the Resource API gem onto the server and perform
#           a reboot of the server.
#
# @example Declaring the class
#   include resource_api::server
#
# @param [String] api_version A specific release version of Resource API to install
# @param [Type[Resource]] puppetserver_service  The name of the puppetserver service to reboot
#
# Deprecated by resource_api::install::master

class resource_api::server(
  String $api_version = 'latest',
  Type[Resource] $puppetserver_service = $facts['pe_server_version'] ? {
    /./     => Service['pe-puppetserver'],
    default => Service['puppetserver']
  },
) {

  # since PE and puppet are bundled together, it is enough to only check for the puppet version here
  if versioncmp($facts['puppetversion'], '6.0.0') < 0 {
    package { 'Resource API on the puppetserver':
      ensure   => $api_version,
      name     => 'puppet-resource_api',
      provider => puppetserver_gem,
    }

    Package['Resource API on the puppetserver'] ~> $puppetserver_service
  }
}
