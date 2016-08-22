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

			class Discussion

				CATEGORIES = "discussions/categories".freeze
				FORUMS = "discussions/forums".freeze
				TOPICS = "discussions/topics".freeze
				POSTS = "discussions/posts".freeze

				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				def get_category id
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES, id )
				end

				def get_forum id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FORUMS, id )
				end

				def get_topic id
					Freshdesk::Api::Client.convert_to_hash( @connection.get TOPICS, id )
				end

				def create_category payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post CATEGORIES, payload )
				end

				def create_forum payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post FORUMS, payload )
				end

				def create_topic payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post TOPICS, payload )
				end

				def create_post topic_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post POSTS, payload, topic_id, nil, "create_post" )
				end

				def list_categories
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES )
				end

				def delete_category id
					( @connection.delete CATEGORIES, id ).code
				end

				def delete_forum id
					( @connection.delete FORUMS, id ).code
				end

				def delete_topic id
					( @connection.delete TOPICS, id ).code
				end				

			end
		end
	end
end