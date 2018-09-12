require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'resource_api_test',
  docs: <<-EOS,
      This is a type used for testing the Resource API Gem
    EOS
  features: [],
  attributes:   {
    ensure:      {
      type:    'Enum[present, absent]',
      desc:    'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name:        {
      type:      'String',
      desc:      'The name of the resource you want to manage.',
      behaviour: :namevar,
    },
  },
)
