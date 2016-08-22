module Freshdesk
	module Api
		module Client
			def self.convert_to_hash response
				JSON.parse response.to_str
			end

			def self.delete_status_wrapper
				response = yield if block_given?
				if !response.nil? and (response >= 200 and response < 299)
					true
				else
					false
				end
			end

			class Ticket

				TICKETS = "tickets".freeze
				NOTES = "conversations/note".freeze

				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				def create_ticket payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post TICKETS, payload )
				end

				def update_ticket id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.put TICKETS, id, payload )
				end

				def delete_ticket id
					( @connection.delete TICKETS, id ).code
				end

				def get_ticket id
					Freshdesk::Api::Client.convert_to_hash( @connection.get TICKETS, id )
				end

				def list_tickets
					Freshdesk::Api::Client.convert_to_hash( @connection.get TICKETS )
				end

				def is_ticket_id_available? id
					begin
						return false if id.to_i.zero?
						get_ticket id.to_i
						return false
					rescue Freshdesk::Api::InvalidEndpointError
						true
					end
				end

				def add_note id, payload
					begin
						Freshdesk::Api::Client.convert_to_hash( @connection.post "tickets/#{id}/#{NOTES}", payload )
					rescue Freshdesk::Api::InvalidEndpointError
						false
					end
				end

			end #end of Ticket
		end
	end
end