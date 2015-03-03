class CamaraUpdater
	# recebe a arrray de hashes
	def self.update_deputados(deputados)
		deputados.each { |deputado| Deputado.create(deputado) }
	end

	def self.update_cotas_parlamentares(lista_cotas)
		lista_cotas.each { |cota| Despesa.create(cota) }
	end
end