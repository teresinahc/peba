require "#{Rails.root}/lib/utils/baixar_dados.rb"

namespace :crawler do
  desc "Baixar dados do site da camara dos deputados"
  task run: :environment do
  	 begin
	  	 ActiveRecord::Base.transaction do
		  	 BaixarDados.setup
		     BaixarDados.baixar_deputados
		     BaixarDados.baixar_despesas
	 	 end
	 rescue
	 	ActiveRecord::Base.rollback
	 end
  end
end
