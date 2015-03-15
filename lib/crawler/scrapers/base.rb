require 'open-uri'
require 'zip'

module Crawler
  module Scrapers
    class Base
      
      TMP_PATH = File.join(Rails.root, 'tmp')

      def fetch_url(url, limit = 10, method = :get)
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        response = Net::HTTP.get_response(URI(url))

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response['location']
          fetch_url(location, limit - 1)
          location
        else
          response.value
        end
      end

      def fetch_zip(url)
        file_name     = url.split("/").last
        zip_tmp_path  = tmp_file_path(file_name)

        File.delete(zip_tmp_path) if File.exist?(zip_tmp_path)

        open(zip_tmp_path, 'wb') do |file|
          file << open(url).read
        end

        Zip::File.open(zip_tmp_path)
      end

      def tmp_file_path(file_name)
        File.join(TMP_PATH, file_name)
      end

    end
  end
end