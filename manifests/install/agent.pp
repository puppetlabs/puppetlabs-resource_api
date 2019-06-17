# @summary This class installs the Resource API gem into puppet agent
#
# @example Declaring the class
#   include resource_api::install::agent
#
# @param [String]
#    api_version A specific release version of Resource API to install
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
