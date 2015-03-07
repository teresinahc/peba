class CamaraUpdater
	# recebe a arrray de hashes
	def self.update_deputados(deputados)
		deputados.each do |deputado|
      Deputado.create(deputado)
    end
	end

	def self.update_cotas_parlamentares(lista_cotas)
		lista_cotas.each do |cota| 
      Despesa.create(cota)
    end
	end
end