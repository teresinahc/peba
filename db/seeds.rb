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



