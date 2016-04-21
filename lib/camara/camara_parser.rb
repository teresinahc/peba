require 'open-uri'

class CamaraParser
  def self.parse_deputados(content)
    document = Nokogiri::XML.parse(content)
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

  def self.parse_cota_parlamentar(content)
    doc       = Nokogiri::XML.parse(content)
    despesa  = doc.css("DESPESA")

    if !despesa.css("ideCadastro").text.blank? and !despesa.css('txtCNPJCPF').text.blank? and !despesa.css("txtNumero").text.blank?

      deputado = Rails.cache.fetch("deputados_#{despesa.css('ideCadastro').text}", expires_in: 4.year) do
        Deputado.find_by_id_cadastro(despesa.css("ideCadastro").text)
      end

      data_emissao = despesa.css('datEmissao').text

      registro = {
        :matricula                  => despesa.css('nuCarteiraParlamentar').text,
        :nome_parlamentar           => despesa.css('txNomeParlamentar').text,
        :beneficiario               => despesa.css('txtFornecedor').text,
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
      } unless deputado.nil?
    end

    registro
  end

end
