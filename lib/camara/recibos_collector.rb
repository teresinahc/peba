require 'open-uri'
require 'nokogiri'

module RecibosCollector

  def self.coleta_nu_deputado_id
    deputados = Hash.new
    html      = Nokogiri::HTML(open('http://www.camara.gov.br/cota-parlamentar/index.jsp'))

    html.xpath('//*[@id="listaDep"]/option').each { |op| deputados[op.text.strip] = op.attribute('value').text }

    return deputados
  end

  def self.run
    deputados_select_ids = self.coleta_nu_deputado_id
    Deputado.all.each do |deputado|
      self.abre_pagina_recibos(deputado, deputados_select_ids)
    end
  end

  def self.abre_pagina_recibos(deputado, deputados_select_ids)
    if defined? deputados_select_ids[deputado.nome_parlamentar]
      puts "Buscando deputado: #{deputado.nome_parlamentar} (#{deputado.id - 1}/#{513})"
      (2015..Time.now.year).each do |year|
        (1..Time.now.month).each do |month|
          url = "http://www.camara.gov.br/cota-parlamentar/cota-analitico?nuDeputadoId=#{deputados_select_ids[deputado.nome_parlamentar].to_s.rjust(2, '0')}&numMes=#{month.to_s.rjust(2, '0')}&numAno=#{year.to_s}&numSubCota="
          begin
            page = Nokogiri::HTML(open(url))
            self.pega_links_dos_recibos(page)
            puts "[SUCCESS]: #{url}"
          rescue Exception => e
            puts "[ERROR]: #{url}"
          end
        end
      end
    end
  end

  def self.pega_links_dos_recibos(page)
    page.css('#content table tr').each do |item|
      if item.css('td:nth-child(3) > a').count >= 1
        filtro = {
          cpf_cnpj:  item.css('td:first-child').text.strip,
          numero:     item.css('td:nth-child(3) > a').text.strip
        }
        self.salva_despesa(filtro, 'http://www.camara.gov.br' + item.css('td:nth-child(3) > a').attribute('href').text.strip)
      end
    end
  end

  def self.salva_despesa(filtro, link_despesa)
    despesa = Despesa.where(filtro).first
    
    if despesa
      despesa.url_recibo = link_despesa
      despesa.save
    end
  end

end
