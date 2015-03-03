namespace :crawler do
  desc "Baixar dados do site da camara dos deputados"
  task run: :environment do
  	 begin
  	 	camara_collector = CamaraCollector.new
  	 	camara_collector.recuperar_deputados
  	 	camara_collector.recuperar_cota_parlamentar
	 rescue
	 	raise ActiveRecord::Rollback
	 end
  end
end
