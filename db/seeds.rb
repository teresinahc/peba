# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

url= "http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados"
xml_file = open(url) { |io| io.read }
system "rm AnoAtual.*"
system "wget http://www.camara.gov.br/cotas/AnoAtual.zip && unzip AnoAtual.zip"

doc = Nokogiri::XML.parse(xml_file)

deputados = doc.css("deputado")

lista = deputados.map do |deputado|
   {
     :nome => deputado.css("nome").text,
     :partido => deputado.css("partido").text,
     :matricula => deputado.css("matricula").text,
     :url_foto => deputado.css("urlFoto").text,
     :email => deputado.css("email").text
   }
end 

lista.each do |deputado|
   Deputado.create(deputado)
end


xml_file = File.read("AnoAtual.xml")
doc = Nokogiri::XML.parse(xml_file)
despesas = doc.css("DESPESA")

lista_despesas = despesas.map do |despesa|
  deputado = Deputado.find_by_matricula(despesa.css("nuCarteiraParlamentar").text)
  data_emissao = despesa.css("datEmissao").text
  unless deputado.nil?
	  {
	    :matricula => despesa.css("nuCarteiraParlamentar").text,
	    :beneficiario => despesa.css("txtBeneficiario").text,
	    :data_emissao=> data_emissao.empty? ? nil : Date.parse(data_emissao),
	    :valor_liquido => despesa.css("vlrDocumento").text,
	    :cpf_cnpj => despesa.css("txtCNPJCPF").text,
	    :id_cadastro => despesa.css("ideCadastro").text.to_i,
	    :num_mes => despesa.css("numMes").text.to_i,
	    :num_ano => despesa.css("numAno").text.to_i,
	    :num_parcela => despesa.css("numParcela").text.to_i,
	    :deputado_id => deputado.id
	  }
  end
end 


lista_despesas.each { |despesa| Despesa.create(despesa) }




