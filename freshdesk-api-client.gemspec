# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "freshdesk-api-client"
  spec.version       = "1.0.0"
  spec.authors       = ["Dineshprabu S"]
  spec.email         = "dineshsprabu@gmail.com"
  spec.summary       = %q{Freshdesk API client for v1.}
  spec.description   = %q{This client can be used for accessing Tickets, Users, Discussions and Forums on Freshdesk.}
  spec.homepage      = "https://github.com/dineshsprabu/freshdesk-api-client"
  spec.require_paths = ["lib","lib/freshdesk/api/client"]
  spec.license       = 'MIT'
  spec.files         = ["lib/freshdesk-api-client.rb"]+Dir["lib/freshdesk/api/client/*.rb"]
  spec.add_runtime_dependency 'rest-client', "1.6.7"
end