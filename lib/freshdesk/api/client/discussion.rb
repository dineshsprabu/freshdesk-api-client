module Freshdesk
	module Api
		module Client

			class Discussion

				CATEGORIES = "discussions/categories".freeze
				FORUMS = "discussions/forums".freeze
				TOPICS = "discussions/topics".freeze
				POSTS = "discussions/posts".freeze

				#Initialize with your freshdesk account url and api key.
				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				#Get category by passing its id.
				def get_category id
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES, id )
				end

				#Get Forum by passing its id.
				def get_forum id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FORUMS, id )
				end

				#Get topic by passing its id.
				def get_topic id
					Freshdesk::Api::Client.convert_to_hash( @connection.get TOPICS, id )
				end

				#Create a category by passing payload. Please refer https://freshdesk.com/api#forum
				def create_category payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post CATEGORIES, payload )
				end

				#Create a forum by passing payload. Please refer https://freshdesk.com/api#forum
				def create_forum payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post FORUMS, payload )
				end

				#Create a topic by passing payload. Please refer https://freshdesk.com/api#forum
				def create_topic payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post TOPICS, payload )
				end

				#Create a post by passing payload. Please refer https://freshdesk.com/api#forum
				def create_post topic_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post POSTS, payload, topic_id, nil, "create_post" )
				end

				#Lists all categories 
				def list_categories
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES )
				end

				#Delete category by passing its id.
				def delete_category id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete CATEGORIES, id ).code
					end
				end

				#Delete Forum by passing its id.
				def delete_forum id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete FORUMS, id ).code
					end
				end

				#Delete Post by passing its id. A Post cannot be deleted alone.
				def delete_topic id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete TOPICS, id ).code
					end
				end				

			end
		end
	end
end
