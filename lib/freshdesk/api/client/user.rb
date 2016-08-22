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

			class User

				USERS = "contacts".freeze 
				AGENTS = "agents".freeze

				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				def create_user payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post USERS, payload )
				end

				def update_user id, payload
					(@connection.put USERS, id, payload).code
				end

				def get_user_by_email email
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS, nil, "query="+URI.encode("email is #{email}") )
				end

				def get_user_by_id id
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS, id )
				end

				def get_agent_by_id id
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS, id)
				end

				def get_agent_by_email email
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS, nil, "query="+URI.encode("email is #{email}") )
				end

				def get_agent_or_user_by_email email
					user = get_user_by_email email
					unless user.nil? or user.empty?
						{ type: :user, response: user[0] }
					else
						agent = get_agent_by_email email
						unless agent.nil? or agent.empty?
							{ type: :agent, response: agent[0] }
						else
							[]
						end
					end
				end

				def delete_user id
					( @connection.delete USERS, id ).code
				end

				def delete_agent id
					begin
						( @connection.delete AGENTS, id ).code
					rescue Freshdesk::Api::ServerError
						200
					end
				end

				def list_users
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS )
				end

				def list_agents
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS )
				end

			end #end of User
		end
	end
end
