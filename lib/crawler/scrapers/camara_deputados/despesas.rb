module Crawler::Scrapers
  class CamaraDeputados::Despesas < Base

    URL_ZIP_DESPESAS = 'http://www.camara.gov.br/cotas/AnoAtual.zip'

    def extrai_lista_despesas
      zip_entry = fetch_zip(URL_ZIP_DESPESAS).glob('*.xml').first
      xml_path  = File.join(TMP_PATH, zip_entry.name)

      File.delete(xml_path) if File.exists?(xml_path) 

      xml_path if zip_entry.extract xml_path
    end

    def parse_lista_despesas
      doc       = Nokogiri::XML(open(extrai_lista_despesas))
      despesas  = doc.css("DESPESA")
      registros = Array.new

      despesas.map do |despesa|
        
        next unless despesa_valida(despesa)

        deputado = Rails.cache.fetch("deputados_#{despesa.css('ideCadastro').text}", expires_in: 4.year) do
          Deputado.find_by_id_cadastro(despesa.css("ideCadastro").text)
        end

        next if deputado.nil?

        data_emissao = despesa.css('datEmissao').text
        registros << {
          :matricula                  => despesa.css('nuCarteiraParlamentar').text,
          :nome_parlamentar           => despesa.css('txNomeParlamentar').text,
          :beneficiario               => despesa.css('txtBeneficiario').text,
          :descricao                  => despesa.css('txtDescricao').text,
          :data_emissao               => data_emissao.empty? ? '' : Date.parse(data_emissao),
          :valor_documento            => despesa.css('vlrDocumento').text,
          :valor_liquido              => despesa.css('vlrLiquido').text,
          :valor_glosa                => despesa.css('vlrGlosa').text,
          :cpf_cnpj                   => despesa.css('txtCNPJCPF').text,
          :id_cadastro                => despesa.css('ideCadastro').text.to_i,
          :num_mes                    => despesa.css('numMes').text.to_i,
          :num_ano                    => despesa.css('numAno').text.to_i,
          :num_parcela                => despesa.css('numParcela').text.to_i,
          :num_lote                   => despesa.css('numLote').text.to_i,
          :num_ressarcimento          => despesa.css('numRessarcimento').text.to_i,
          :num_sub_cota               => despesa.css('numSubCota').text.to_i,
          :num_especificacao_sub_cota => despesa.css('numEspecificacaoSubCota').text.to_i,
          :deputado_id                => deputado.id,
          :numero                     => despesa.css('txtNumero').text
        }
      end

      return registros
    end

    def salva_despesas
      despesas_atuais = Despesa.pluck(:id_cadastro, :cpf_cnpj, :numero)
      parse_lista_despesas.each do |despesa|
        Despesa.create(despesa) unless despesas_atuais.include?([despesa[:id_cadastro], despesa[:cpf_cnpj], despesa[:numero]])
      end
    end

    def despesa_valida(xml)
      %w[ideCadastro txtCNPJCPF txtNumero].each do |campo|
        if !xml.css(campo).text.blank?
          return true
        end
      end
    end

  end
end