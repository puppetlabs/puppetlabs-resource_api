# resource_api::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include resource_api::server
class resource_api::server(
  String $api_version = 'latest',
  Type[Resource] $puppetserver_service = $facts['pe_server_version'] ? {
    /./     => Service['pe-puppetserver'],
    default => Service['puppetserver']
  },
) {
  package { 'Resource API on the puppetserver':
    ensure   => $api_version,
    name     => 'puppet-resource_api',
    provider => puppetserver_gem,
  }

  Package['Resource API on the puppetserver'] ~> $puppetserver_service
}
