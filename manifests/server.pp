# resource_api::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include resource_api::server
class resource_api::server {
  package { 'Resource API on the puppetserver':
    name     => 'puppet-resource_api',
    provider => puppetserver_gem,
  }
}
