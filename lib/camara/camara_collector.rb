require "#{Rails.root}/lib/base_collector.rb"
require "#{Rails.root}/lib/camara/camara_parser.rb"
require "#{Rails.root}/lib/camara/camara_updater.rb"

class CamaraCollector < BaseCollector
	# faz a requisição, converte e salva
	def recuperar_deputados
		url = "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"
		content = self.fetch(url).body
		lista_deputados = CamaraParser.parse_deputados(content)
		CamaraUpdater.update_deputados(lista_deputados)
	end

	def recuperar_cota_parlamentar
		content = self.fetch_zip("http://www.camara.gov.br/cotas/AnoAtual.zip","AnoAtual")
		lista_cotas = CamaraParser.parse_cota_parlamentar(content)
		CamaraUpdater.update_cotas_parlamentares(lista_cotas)
	end

	# def recuperar_cota_parlamentar_analitica
	# end
end