require "#{Rails.root}/lib/camara/base_collector.rb"
require "#{Rails.root}/lib/camara/camara_parser.rb"
require "#{Rails.root}/lib/camara/camara_updater.rb"
require "csv"

class CamaraCollector < BaseCollector
	# faz a requisição, converte e salva
	def recuperar_deputados
		url = "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"
		content = self.fetch(url).body
		lista_deputados = CamaraParser.parse_deputados(content)
		CamaraUpdater.update_deputados(lista_deputados)
	end


	def recuperar_total_votos
		url  = "http://inter04.tse.jus.br/ords/dwtse/f?p=201403:133:4187832305687943:FLOW_EXCEL_OUTPUT_R65632543115268150_pt-br"
		file = "#{Rails.root}/tmp/votos.csv"

		system "curl --silent #{url} > #{file}"
    response = File.read(file).encode("utf-8", "iso-8859-1")

    # remove todas as linhas desnecessarias
    response.gsub!(/"";"";"";"";"";"";"";"[0-9]+(\.[0-9]+)?(\.[0-9]+)?"\n/, '')

    resultado = CSV.parse(response, headers: true, col_sep: ';', quote_char: '"')
    CamaraUpdater.update_votos(resultado)
	end


	def recuperar_cota_parlamentar
		content = self.fetch_zip("http://www.camara.gov.br/cotas/AnoAtual.zip","AnoAtual")
		lista_cotas = CamaraParser.parse_cota_parlamentar(content)
		CamaraUpdater.update_cotas_parlamentares(lista_cotas)
	end

	# def recuperar_cota_parlamentar_analitica
	# end
end