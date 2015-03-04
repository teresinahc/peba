require 'open-uri'
require 'nokogiri'

class RecibosCollector

  def self.coleta_nu_deputado_id
    deputados = Hash.new
    html      = Nokogiri::HTML(open('http://www.camara.gov.br/cota-parlamentar/index.jsp'))
    
    html.xpath('//*[@id="listaDep"]/option').each { |op| deputados[op.text.strip] = op.attribute('value').text }
    
    return deputados
  end

  def self.coleta_recibos
    deputados_ids = self.coleta_nu_deputado_id
    Deputado.all.each do |deputado|
      puts deputado.nome_parlamentar
      begin
        page = Nokogiri::HTML(open("http://www.camara.gov.br/cota-parlamentar/cota-analitico?nuDeputadoId=#{deputados_ids[deputado.nome_parlamentar]}&numMes=2&numAno=2015&numSubCota="))
        page.css('#content table tr').each do |item|
          if item.css('td:nth-child(3) > a').count >= 1
            filtro = {
              cpf_cnpj:  item.css('td:first-child').text.strip,
              numero:     item.css('td:nth-child(3) > a').text.strip
            }
            despesa = Despesa.where(filtro).first
            if despesa
              despesa.url_recibo = 'http://www.camara.gov.br' + item.css('td:nth-child(3) > a').attribute('href').text.strip
              despesa.save
            end
          end
        end
      rescue
        puts 'Treta!'
      end
    end
  end

end