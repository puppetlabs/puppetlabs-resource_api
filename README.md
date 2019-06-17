
# resource_api

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with resource_api](#setup)
    * [What resource_api affects](#what-resource_api-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with resource_api](#beginning-with-resource_api)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Development - Guide for contributing to the module](#development)

## Module Description

This module installs the Puppet Resource API gem into a puppet agent and pe-pupetserver or puppetserver service. This is necessary to use any type or provider that is implemented using the Puppet Resource API.

## Setup

### What resource_api affects

The Puppet Resource API gem will be installed into a puppet agent using the `puppet_gem` provider, and into a puppetserver service using the `puppetserver_gem` provider. To activate the gem, a reload of the puppetserver service is necessary. In most cases, this should happen automatically and cause little to no interruption to service.

### Setup Requirements

The Puppet Resource API is only compatible with Puppet 4.7 and later.
There are no further specific requirements.

### Beginning with resource_api

To install dependencies of the Puppet Resource API:

1. Classify or apply the `resource_api` class on each master (master of masters, and if present, compile masters and replica master) that needs to process Puppet Resource API types and providers.
1. Classify or apply the `resource_api` class on each puppet agent that needs to apply Puppet Resource API types and providers.

To specify the version of the Puppet Resource API gem you want to install, use the `$api_version` parameter with the `resource_api::install::master` and `resource_api::install::agent` classes instead of using the `resource_api` class.

To specify a non-default `puppetserver` service resource (if you're not using the standard service) use the `$puppetserver_service` parameter with the  `resource_api::install::master` class instead of using the `resource_api` class.

Run `puppet agent -t` on the master(s) before using the Puppet Resource API on the agent(s).

## Reference

See [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-resource_api/blob/master/REFERENCE.md)

## Development

Execute the Puppet Strings task to generate the latest [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-resource_api/blob/master/REFERENCE.md)

 ``` bash
 bundle exec rake 'strings:generate[manifests/**/*.pp,,,,,REFERENCE.md,true]'
 ```

Please submit any issues, or contributions on https://github.com/puppetlabs/puppetlabs-resource_api
