require "#{Rails.root}/lib/utils/baixar_dados.rb"

namespace :crawler do
  desc "Baixar dados do site da camara dos deputados"
  task run: :environment do
  	 begin
	  	 ActiveRecord::Base.transaction do
		  	 BaixarDados.setup
	 	 end
	 rescue
	 	raise ActiveRecord::Rollback
	 end
  end
end
