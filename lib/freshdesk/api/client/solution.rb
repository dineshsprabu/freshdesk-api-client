module Freshdesk
	module Api
		module Client

			class Solution

				CATEGORIES = "solution/categories".freeze
				FOLDERS = "solution/folders".freeze
				ARTICLES = "solution/articles".freeze

				#Initialize with your freshdesk account url and api key.
				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				#Create category by passing its id. Please refer https://freshdesk.com/api#solution-category
				def create_category payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post CATEGORIES, payload )
				end


				#Create folder by passing its id. Please refer https://freshdesk.com/api#solution-category
				def create_folder category_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post FOLDERS, payload, category_id, nil, "create_folder" )
				end

				#Create article by passing its id. Please refer https://freshdesk.com/api#solution-category
				def create_article category_id, topic_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post ARTICLES, payload, category_id, topic_id, "create_article" )
				end

				#Get category by its id.
				def get_category id
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES, id )
				end

				#Get folder by its id.
				def get_folder id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FOLDERS, id )
				end

				#Get article by its id.
				def get_article id
					Freshdesk::Api::Client.convert_to_hash( @connection.get ARTICLES, id )
				end

				#List all articles by passing the category id and folder id together.
				def list_articles category_id, folder_id
					Freshdesk::Api::Client.convert_to_hash( @connection.get ARTICLES, category_id, nil, folder_id, "list_articles" )
				end

				#List all folders by it category id.
				def list_folders category_id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FOLDERS, category_id, nil, nil,  "list_folders" )
				end

				#List all categories.
				def list_categories 
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES )
				end

				#Delete category by its id.
				def delete_category id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete CATEGORIES, id, "delete_category" ).code
					end
				end

				#Delete folder by category id and folder id.
				def delete_folder category_id, id
					Freshdesk::Api::Client.delete_status_wrapper do
						( @connection.delete FOLDERS, category_id, id, "delete_folder" ).code
					end
				end

			end 

		end
	end
end
