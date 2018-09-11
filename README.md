
# resource_api

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with resource_api](#setup)
    * [What resource_api affects](#what-resource_api-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with resource_api](#beginning-with-resource_api)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module installs the Resource API gem into your PE, puppetserver and
puppet-agent installations. This is necessary to use any type and provider that's implemented using the Resource API.

## Setup

### What resource_api affects

The Resource API will get installed into your PE or puppetserver installation
using the puppetserver_gem utility. To activate it a reload of the puppetserver
is necessary. In most cases this should work automatically and cause little to
no interruption to your service.

### Setup Requirements

The Resource API is only compatible with puppet 4.7 and later. There are no
further specific requirements.

### Beginning with resource_api

To be able to use Resource API providers, two things need to happen:

* on each puppetserver or PE master that needs to process Resource API providers, classify or apply the `resource_api::server` class.

* on each puppet agent that needs to apply Resource API providers, classify or apply the `resource_api::agent` class.

You can use the `$api_version` parameter to select which version of the Resource API gem gets installed.

You can use the `$puppetserver_service` parameter on the `resource_api::server` class to specify a non-default `puppetserver` service resource, if you're not using the standard ones.

## Reference

See [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-resource_api/blob/master/REFERENCE.md)

## Development

Execute the Puppet Strings task to generate the latest [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-resource_api/blob/master/REFERENCE.md)

 ``` bash
 bundle exec rake strings:generate[manifests/*.pp,,,,,REFERENCE.md,true]
 ```

Please submit any issues, or contributions on https://github.com/puppetlabs/puppetlabs-resource_api
