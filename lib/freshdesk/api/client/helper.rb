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
		end
	end
end