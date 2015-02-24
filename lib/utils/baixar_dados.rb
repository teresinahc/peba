require 'open-uri'

module BaixarDados
  def self.baixar_deputados
    url= "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"
    file = open(url)
    sha1hash = Digest::SHA1.file(file).to_s
    VersaoWebService.create(:url => url, :sha1hash => sha1hash,:data_arquivo => Date.today)
    xml_file = file.read { |io| io.read }
    doc = Nokogiri::XML.parse(xml_file)
    deputados = doc.css("deputado")

    deputados.map do |deputado|
       {
         :nome => deputado.css("nome").text,
         :nome_parlamentar => deputado.css("nomeParlamentar").text,
         :partido => deputado.css("partido").text,
         :matricula => deputado.css("matricula").text,
         :url_foto => deputado.css("urlFoto").text,
         :email => deputado.css("email").text,
         :uf => deputado.css("uf").text,
         :id_cadastro => deputado.css("idDeCadastro").text.to_i
       }
    end.each {|deputado| Deputado.create(deputado) } 
  end

  def self.baixar_despesas
    url = "http://www.camara.gov.br/cotas/AnoAtual.zip"
    system "wget #{url} && unzip AnoAtual.zip"
    xml_file = File.read("AnoAtual.xml")
    sha1hash = Digest::SHA1.file("AnoAtual.xml").to_s
    VersaoWebService.create(:url => url, :sha1hash => sha1hash,:data_arquivo => Date.today)
    
    doc = Nokogiri::XML.parse(xml_file)
    despesas = doc.css("DESPESA")

    despesas.map do |despesa|
      deputado = Deputado.find_by_matricula(despesa.css("nuCarteiraParlamentar").text)
      data_emissao = despesa.css("datEmissao").text
      unless deputado.nil?
        {
          :matricula => despesa.css("nuCarteiraParlamentar").text,
          :beneficiario => despesa.css("txtBeneficiario").text,
          :descricao => despesa.css("txtDescricao").text,
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
    if VersaoWebService.atualizado?("http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados")
      self.baixar_deputados
    end
    if VersaoWebService.atualizado?("http://www.camara.gov.br/cotas/AnoAtual.zip")
      self.baixar_despesas
    end
  end

end





