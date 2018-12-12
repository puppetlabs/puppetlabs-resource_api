# Install resource_api module dependencies on a puppet agent or master.
#
# A proxy agent needs to be classified with this class before it can use
# device modules that use the resource_api.
#
# Every master: master of masters, and if present, compile masters and replica
# needs to be classified with this class before it can compile catalogs for
# device modules that use the resource_api.
#
# @summary Install dependencies into the puppet agent and puppetserver service
#
# @example
#   include resource_api::install

class resource_api::install {

  include resource_api::install::agent

  if $facts['puppetserver_installed'] {
    include resource_api::install::master
  }

}
