# resource_api::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include resource_api::server
class resource_api::server($puppetserver_service = $facts['pe_server_version'] ? { /./ => Service['pe-puppetserver'], default => Service['puppetserver'] } ) {
  package { 'Resource API on the puppetserver':
    ensure   => 'latest',
    name     => 'puppet-resource_api',
    provider => puppetserver_gem,
  }

  Package['Resource API on the puppetserver'] ~> $puppetserver_service
}
