# Freshdesk::Api::Client

Freshdesk API client for accessing Users, Agents, Tickets, Discussions, Solutions using API v1.0.

View the gem at (rubygems.org)[https://rubygems.org/gems/freshdesk-api-client]

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'freshdesk-api-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install freshdesk-api-client

##Usage 

Creating a ticket.

```ruby

ticket = Freshdesk::Api::Client::Ticket.new 'https://helpdesk-name.freshdesk.com', 'your-api-key'

ticket.create_ticket({ helpdesk_ticket: { description: "Details about the issue", subject: "Support Needed", email: "tom@noemail.com", priority: 1, "status": 2 }})

```

Check the (documentation)[http://www.rubydoc.info/gems/freshdesk-api-client/0.0.2] here, for all the functionalities.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dineshsprabu/freshdesk-api-client.

