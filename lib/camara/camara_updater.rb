class CamaraUpdater
	# recebe a arrray de hashes
	def self.update_deputados(deputados)
    puts 'Sincronizando deputados'

		deputados.each do |deputado|
      registro = Deputado.where(id_cadastro: deputado[:id_cadastro]).first_or_create
      registro.update(deputado)
    end
	end

	def self.update_cotas_parlamentares(despesas)
    puts 'Sincronizando despesas'

    despesas_atuais = Despesa.pluck(:id_cadastro, :cpf_cnpj, :numero)
		despesas.each do |despesa| 
      if !despesas_atuais.include?([despesa[:id_cadastro], despesa[:cpf_cnpj], despesa[:numero]])        
        Despesa.create(despesa)
      end
    end
	end
end