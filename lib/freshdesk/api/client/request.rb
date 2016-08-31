require 'rest_client'

module Freshdesk
	module Api
		module Client			
			class Request

				def initialize base_url, api_key
					@base_url = base_url
					@auth = create_auth_header api_key 
				end

				def get endpoint, id=nil, filters=nil, secondary_id=nil, method=nil
					url = create_url endpoint, id, filters, secondary_id, method
					p "GET #{url}"
					handle_exceptions do
						RestClient::Request.execute( url: url, method: :get, headers: @auth )
					end
				end

				def post endpoint, payload, primary_id=nil, secondary_id=nil, method=nil
					url = create_url endpoint, primary_id, nil, secondary_id, method
					p "POST #{url}"
					handle_exceptions do
						RestClient::Request.execute( 
							payload: payload.to_json,
	              			headers: @auth.merge({content_type: "application/json"}),
	              			method: :post,
	              			url: url
						)
					end
				end

				def put endpoint, id, payload
					url = create_url endpoint, id
					p "PUT #{url}"
					handle_exceptions do
						RestClient::Request.execute( 
							payload: payload.to_json,
	              			headers: @auth.merge({content_type: "application/json"}),
	              			method: :put,
	              			url: url
						)
					end
				end

				def delete endpoint, primary_id, secondary_id=nil, method=nil
					url = create_url endpoint, primary_id, nil, secondary_id, method
					p "DELETE #{url}"
					handle_exceptions do
						RestClient::Request.execute( url: url, method: :delete, headers: @auth )
					end
				end

				private

				def handle_exceptions
					begin
						yield if block_given?
					rescue RestClient::NotFound
						raise Freshdesk::Api::InvalidEndpointError, "Endpoint is Invalid"
					rescue RestClient::InternalServerError
						raise Freshdesk::Api::ServerError, "Server Error"
					rescue RestClient::UnprocessableEntity
	              		raise Freshdesk::Api::AlreadyExistsError, "Entity already exists"
	            	rescue RestClient::Found
	              		raise Freshdesk::Api::ConnectionError, "Connection to the server failed. Please check username/password"
	            	rescue Exception
	              		raise
	            	end
				end

				def create_url(endpoint, id=nil, filters=nil, secondary_id=nil, method=nil)
		        	base = @base_url.end_with?("/") ? @base_url : "#{@base_url}/"
		        	endpoint = endpoint.end_with?("/") ? endpoint : "#{endpoint}/"

		        	url = "#{base}#{endpoint}#{id}"
		        	url = "#{base}helpdesk/#{endpoint}#{id}" if(endpoint.include? "tickets" or endpoint.include? "conversations")
		        	url = "#{base}discussions/topics/#{id}/posts" if(endpoint.include? "discussions/posts" and !id.nil? and method.eql? "create_post")
		        	url = "#{base}solution/categories/#{id}/folders" if(method.eql? "create_folder")
		        	url = "#{base}solution/categories/#{id}/folders/#{secondary_id}/articles" if(method.eql? "create_article")
		        	url = "#{base}solution/categories/#{id}" if(method.eql? "list_folders" or method.eql? "delete_category")
		        	url = "#{base}solution/categories/#{id}/folders/#{secondary_id}" if(method.eql? "list_articles" or method.eql? "delete_folder")


		        	if url.end_with?("/")
		            	url = url.slice(0, url.length - 1)
		            end
		            return "#{url}.json?#{filters}" unless filters.nil?
		            "#{url}.json"
		        end

		        def create_auth_header api_key
		        	token = Base64.encode64("#{api_key}:X")
		        	{Authorization: "Basic #{token}"}
		        end
		        
			end
		end
	end
end