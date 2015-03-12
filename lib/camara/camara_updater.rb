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


  def self.update_votos(resultados)
    puts 'Sincronizando total de votos'

    self.atualizar_deputados_estaticamente

    resultados.each do |row|
      deputado = Deputado.find_by nome: row["Candidato"], partido: row["Partido"].gsub(/\s/, '')

      if deputado.nil?
        next
      end

      deputado.update_attributes({
        total_votos:          row["Votação"].gsub(/\./, "").to_i,
        porcentagem_votos:    row["% Válidos"].gsub(/,/, ".").to_f,
        situacao_candidatura: row["Situação"]
      })
    end
  end


  private

  # candidatos nao encontrados automaticamente devido a divergencias de nomes das duas fontes de candidatos
  # TODO melhorar o metodo para idendificar candidados divegerntes
  def self.atualizar_deputados_estaticamente
    # nome, total_votos, porcentagem_votos, situacao_candidatura
    fixos = [
      ['BRUNIELE FERREIRA GOMES',                  45381,  0.45, 'Eleito por média' ],
      ['JOAO HENRIQUE HOLANDA  CALDAS',            135929, 9.82, 'Eleito por QP'    ],
      ['GIVALDO DE SÁ GOUVEIA',                    82582,  5.96, 'Eleito por QP'    ],
      ['ANTONIO PEDRO DE SIQUEIRA INDIO DA COSTA', 91523,  1.20, 'Eleito por QP'    ],
      ['ÁTILA SIDNEY LINS ALBUQUERQUE',            89453,  5.39, 'Eleito por média' ],
      ['JOAQUIM PASSARINHO PINTO DE SOUZA PORTO',  76148,  2.03, 'Eleito por QP'    ],
      ['JOVAIR DE OLIVEIRA ARANTES',               92945,  3.06, 'Eleito por QP'    ],
      ['JOÃO MARCELO SANTOS SOUZA',                83847,  2.68, 'Eleito por média' ]
    ]

    fixos.each do |attr|
      deputado = Deputado.find_by nome: attr[0]

      deputado.update_attributes({
        total_votos:          attr[1],
        porcentagem_votos:    attr[2],
        situacao_candidatura: attr[3]
      })
    end
  end
end