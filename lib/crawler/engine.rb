module Crawler

  module Engine
    
    DEPUTADOS_ATUAIS       = 'http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados'
    URL_DESPESAS_ANO_ATUAL = 'http://www.camara.gov.br/cotas/AnoAtual.zip'
    
    def self.run
      deputados = Scrapers::CamaraDeputados::Deputados.new(DEPUTADOS_ATUAIS)
      deputados.capturar

      despesas  = Scrapers::CamaraDeputados::Despesas.new(URL_DESPESAS_ANO_ATUAL)
      despesas.capturar

      recibos   = Scrapers::CamaraDeputados::RecibosDespesas.new
      despesas.capturar
    end

  end

end