class CamaraUpdater
	# recebe a arrray de hashes
	def self.update_deputados(deputados)
		deputados.each do |deputado|
      registro = Deputado.where(id_cadastro: deputado[:id_cadastro]).first_or_create
      registro.update(deputado)
    end
	end

  def self.update_votos(deputados)
    deputados.each do |candidato|
      deputado = Deputado.buscar candidato
    end
  end

	def self.update_cotas_parlamentares(lista_cotas)
		lista_cotas.each do |cota|
      registro = Despesa.where(cpf_cnpj: cota[:cpf_cnpj], numero: cota[:numero], id_cadastro: cota[:id_cadastro]).first_or_create
      registro.update(cota)
    end
	end
end