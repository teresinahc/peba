module DeputadosHelper
  def detalhe_deputado_url(id_cadastro)
    "http://www.camara.gov.br/internet/deputado/Dep_Detalhe.asp?id=#{id_cadastro}"
  end

  def cota_deputado_url(id_cadastro)
    "http://www.camara.gov.br/cota-parlamentar/consulta-cota-parlamentar?ideDeputado=#{id_cadastro}"
  end
end
