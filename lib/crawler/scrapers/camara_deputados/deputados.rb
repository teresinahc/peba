module Crawler::Scrapers
  class CamaraDeputados::Deputados < Base
    
    URL_DEPUTADOS = "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"

    def lista_deputados
      fetch_url(URL_DEPUTADOS).body
    end

    def parse_lista_deputados
      document  = Nokogiri::XML.parse(lista_deputados)
      deputados = document.css("deputado")
      
      deputados.map do |deputado|
        {
          :nome             => deputado.css("nome").text,
          :nome_parlamentar => deputado.css("nomeParlamentar").text,
          :partido          => deputado.css("partido").text,
          :matricula        => deputado.css("matricula").text,
          :url_foto         => deputado.css("urlFoto").text,
          :email            => deputado.css("email").text,
          :uf               => deputado.css("uf").text,
          :id_cadastro      => deputado.css("ideCadastro").text.to_i
        }
      end
    end

    def salva_deputados
      parse_lista_deputados.each do |deputado|
        registro = Deputado.where(id_cadastro: deputado[:id_cadastro]).first_or_create
        registro.update(deputado)
      end
    end

  end
end