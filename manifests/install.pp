# @summary This class installs dependencies of the Resource API
#          into the puppet agent, and/or the puppetserver service.
#
# @example Declaring the class
#   include resource_api::install
class resource_api::install {

  include resource_api::install::agent

  if $facts['puppetserver_installed'] {
    include resource_api::install::master
  }

}

# A proxy agent needs to be classified with this class before it can use
# device modules that use the Resource API.
#
# Every master: master of masters, and if present, compile masters and replica
# needs to be classified with this class before it can compile catalogs for
# device modules that use the Resource API.
