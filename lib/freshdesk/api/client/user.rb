module Freshdesk
	module Api
		module Client
			class User
				USERS = "contacts".freeze 
				AGENTS = "agents".freeze

				#Initialize with your freshdesk account url and api key.
				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				#Create an user with payload. Please refer https://freshdesk.com/api#user
				def create_user payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post USERS, payload )
				end

				#Update an user by passing its id and payload. Please refer https://freshdesk.com/api#user
				def update_user id, payload
					(@connection.put USERS, id, payload).code
				end

				#Get user by passing an email.
				def get_user_by_email email
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS, nil, "query="+URI.encode("email is #{email}") )
				end

				#Get user by passing a valid user id.
				def get_user_by_id id
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS, id )
				end

				#Get agent by passing a valid agent id.
				def get_agent_by_id id
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS, id)
				end

				#Get agent by passing an email.
				def get_agent_by_email email
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS, nil, "query="+URI.encode("email is #{email}") )
				end

				#Get a user or an agent by simply passing the email.
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

				#Delete user by its id.
				def delete_user id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete USERS, id ).code
					end
				end

				#Delete agent by its id.
				def delete_agent id
					begin
						( @connection.delete AGENTS, id ).code
					rescue Freshdesk::Api::ServerError
						200
					end
				end

				#List all users.
				def list_users
					Freshdesk::Api::Client.convert_to_hash( @connection.get USERS )
				end

				#List all agents.
				def list_agents
					Freshdesk::Api::Client.convert_to_hash( @connection.get AGENTS )
				end

			end
		end
	end
end
