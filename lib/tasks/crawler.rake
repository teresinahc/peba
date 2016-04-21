require "#{Rails.root}/lib/camara/camara_collector.rb"
require "#{Rails.root}/lib/camara/recibos_collector.rb"

namespace :crawler do
  desc "Baixar dados do site da camara dos deputados"
  task run: :environment do
    puts 'Iniciando Peba'
    camara_collector = CamaraCollector.new
    camara_collector.recuperar_deputados
    camara_collector.recuperar_total_votos :eleitos
    camara_collector.recuperar_total_votos :suplentes
    camara_collector.recuperar_cota_parlamentar
    RecibosCollector.run

    puts 'Reindexando registros'
    DeputadosIndex.import
  end
end
