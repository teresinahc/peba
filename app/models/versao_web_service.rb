require 'open-uri'

class VersaoWebService < ActiveRecord::Base
	def self.atualizado?(url)
    file     = open(url)
    sha1hash = Digest::SHA1.file(file).to_s

		!self.exists?(:url => url, :sha1hash => sha1hash)
	end
end
