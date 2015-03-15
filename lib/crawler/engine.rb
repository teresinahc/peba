module Crawler

  module Engine
    
    URL_DEPUTADOS_ATUAIS          = 'http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados'
    URL_DESPESAS_ANO_ATUAL        = 'http://www.camara.gov.br/cotas/AnoAtual.zip'
    URL_VOTOS_DEPUTADOS_ELEITOS   = 'https://raw.githubusercontent.com/juliobetta/eleicoes-2014/master/votos_eleitos_turno_1.csv'
    URL_VOTOS_DEPUTADOS_SUPLENTES = 'https://raw.githubusercontent.com/juliobetta/eleicoes-2014/master/votos_suplentes.csv'
    
    def self.run
      puts 'Buscando deputados'
      deputados = Scrapers::CamaraDeputados::Deputados.new(URL_DEPUTADOS_ATUAIS)
      deputados.capturar

      puts 'Buscando despesas dos deputados'
      despesas  = Scrapers::CamaraDeputados::Despesas.new(URL_DESPESAS_ANO_ATUAL)
      despesas.capturar

      puts 'Buscando link dos recibos das despesas dos deputados'
      recibos   = Scrapers::CamaraDeputados::RecibosDespesas.new
      recibos.capturar

      puts 'Atualizando votos dos deputados eleitos'
      votos_deputados_eleitos   = Scrapers::CamaraDeputados::RecibosDespesas.new(URL_VOTOS_DEPUTADOS_ELEITOS)
      votos_deputados_eleitos.capturar

      puts 'Atualizando votos dos deputados suplentes'
      votos_deputados_eleitos   = Scrapers::CamaraDeputados::RecibosDespesas.new(URL_VOTOS_DEPUTADOS_SUPLENTES)
      votos_deputados_eleitos.capturar
    end

  end

end