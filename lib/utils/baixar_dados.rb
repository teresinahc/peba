require 'open-uri'

module BaixarDados
  def self.baixar_deputados
    url= "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"
    xml_file = open(url) { |io| io.read }
    doc = Nokogiri::XML.parse(xml_file)
    deputados = doc.css("deputado")

    deputados.map do |deputado|
       {
         :nome => deputado.css("nome").text,
         :partido => deputado.css("partido").text,
         :matricula => deputado.css("matricula").text,
         :url_foto => deputado.css("urlFoto").text,
         :email => deputado.css("email").text,
         :uf => deputado.css("uf").text
       }
    end.each {|deputado| Deputado.create(deputado) } 
  end

   def self.baixar_despesas
     system "wget http://www.camara.gov.br/cotas/AnoAtual.zip && unzip AnoAtual.zip"
     xml_file = File.read("AnoAtual.xml")
     doc = Nokogiri::XML.parse(xml_file)
     despesas = doc.css("DESPESA")

     despesas.map do |despesa|
      deputado = Deputado.find_by_matricula(despesa.css("nuCarteiraParlamentar").text)
      data_emissao = despesa.css("datEmissao").text
      unless deputado.nil?
        {
          :matricula => despesa.css("nuCarteiraParlamentar").text,
          :beneficiario => despesa.css("txtBeneficiario").text,
          :data_emissao=> data_emissao.empty? ? '' : Date.parse(data_emissao),
          :valor_liquido => despesa.css("vlrDocumento").text,
          :cpf_cnpj => despesa.css("txtCNPJCPF").text,
          :id_cadastro => despesa.css("ideCadastro").text.to_i,
          :num_mes => despesa.css("numMes").text.to_i,
          :num_ano => despesa.css("numAno").text.to_i,
          :num_parcela => despesa.css("numParcela").text.to_i,
          :deputado_id => deputado.id
        }
      end
    end.each { |despesa| Despesa.create(despesa) }
  end

  def self.setup
    system "rm AnoAtual.*"
  end

end





