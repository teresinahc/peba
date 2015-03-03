class BaseCollector
	def self.fetch(uri_str, limit = 10)
	  raise ArgumentError, 'too many HTTP redirects' if limit == 0

	  response = Net::HTTP.get_response(URI(uri_str))

	  case response
	  when Net::HTTPSuccess then
	  	response
	  when Net::HTTPRedirection then
	  	location = response['location']
	  	fetch(location, limit - 1)
	  	location
	  else
	  	response.value
	  end
	end
end