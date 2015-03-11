require "#{Rails.root}/lib/camara/camara_collector.rb"
require "#{Rails.root}/lib/camara/recibos_collector.rb"

namespace :crawler do
  desc "Baixar dados do site da camara dos deputados"
  task run: :environment do
  	 	camara_collector = CamaraCollector.new
  	 	camara_collector.recuperar_deputados
  	 	camara_collector.recuperar_cota_parlamentar
      RecibosCollector.run
  end
end
