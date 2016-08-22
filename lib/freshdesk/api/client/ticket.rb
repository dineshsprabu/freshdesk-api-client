module Freshdesk
	module Api
		module Client
			class Ticket
				TICKETS = "tickets".freeze
				NOTES = "conversations/note".freeze

				#Initialize with your freshdesk account url and api key.
				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				#Create ticket with payload. Please refer https://freshdesk.com/api#ticket
				def create_ticket payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post TICKETS, payload )
				end

				#Update a ticket by passing its id and payload. Please refer https://freshdesk.com/api#ticket
				def update_ticket id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.put TICKETS, id, payload )
				end

				#Delete a ticket by its id.
				def delete_ticket id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete TICKETS, id ).code
					end
				end

				#Get a ticket by its id.
				def get_ticket id
					Freshdesk::Api::Client.convert_to_hash( @connection.get TICKETS, id )
				end

				#List all tickets.
				def list_tickets
					Freshdesk::Api::Client.convert_to_hash( @connection.get TICKETS )
				end

				#Check is ticket id is available by passing the id.
				def is_ticket_id_available? id
					begin
						return false if id.to_i.zero?
						get_ticket id.to_i
						return false
					rescue Freshdesk::Api::InvalidEndpointError
						true
					end
				end

				#Add note by passing the ticket id and payload. Please refer Please refer https://freshdesk.com/api#ticket
				def add_note ticket_id, payload
					begin
						Freshdesk::Api::Client.convert_to_hash( @connection.post "tickets/#{ticket_id}/#{NOTES}", payload )
					rescue Freshdesk::Api::InvalidEndpointError
						false
					end
				end

			end 
		end
	end
end