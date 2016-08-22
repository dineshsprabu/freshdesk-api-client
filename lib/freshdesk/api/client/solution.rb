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

			class Solution

				CATEGORIES = "solution/categories".freeze
				FOLDERS = "solution/folders".freeze
				ARTICLES = "solution/articles".freeze

				def initialize base_url, api_key
					@connection = Freshdesk::Api::Client::Request.new base_url, api_key
				end

				def create_category payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post CATEGORIES, payload )
				end

				def create_folder category_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post FOLDERS, payload, category_id, nil, "create_folder" )
				end

				def create_article category_id, topic_id, payload
					Freshdesk::Api::Client.convert_to_hash( @connection.post ARTICLES, payload, category_id, topic_id, "create_article" )
				end

				def get_category id
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES, id )
				end

				def get_folder id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FOLDERS, id )
				end

				def get_article id
					Freshdesk::Api::Client.convert_to_hash( @connection.get ARTICLES, id )
				end

				def list_articles category_id, folder_id
					Freshdesk::Api::Client.convert_to_hash( @connection.get ARTICLES, category_id, nil, folder_id, "list_articles" )
				end

				def list_folders category_id
					Freshdesk::Api::Client.convert_to_hash( @connection.get FOLDERS, category_id, nil, nil,  "list_folders" )
				end

				def list_categories 
					Freshdesk::Api::Client.convert_to_hash( @connection.get CATEGORIES )
				end

				def delete_category id
					( @connection.delete CATEGORIES, id, "delete_category" ).code
				end

				def delete_folder category_id, id
					( @connection.delete FOLDERS, category_id, id, "delete_folder" ).code
				end

			end #end of Solution

		end
	end
end
