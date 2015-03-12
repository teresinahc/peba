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


  def recuperar_total_votos(tipo = :eleitos)
    tipos_validos = [:eleitos, :suplentes]
    throw Exception.new("Insira um tipo valido") unless tipo.in?(tipos_validos)

    # PRIMEIRO TURNO: o suficiente para pegarmos os deputados
    # "UF";"Cargo";"Nr";"Candidato";"Partido";"Coligação";"Situação";"Votação";"% Válidos";
    if tipo == :eleitos
      url = "http://inter04.tse.jus.br/ords/dwtse/f?p=201403:101:110001388088023:FLOW_EXCEL_OUTPUT_R80771993629315934_pt-br"
    else # suplentes
      url = "http://inter04.tse.jus.br/ords/dwtse/f?p=201403:101:281385371258783:FLOW_EXCEL_OUTPUT_R80771993629315934_pt-br"
    end

    dir  = "#{Rails.root}/tmp"
    file = "#{dir}/votos.csv"

    system "mkdir -p #{dir}"
    system "curl --silent #{url} > #{file}"
    response = File.read(file).encode("utf-8", "iso-8859-1")

    # remove todas as linhas desnecessarias
    File.write(file, response.gsub!(/"";"";"";"";"";"";"";"[0-9]+(\.[0-9]+)?(\.[0-9]+)?";""\n/, ''))

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
