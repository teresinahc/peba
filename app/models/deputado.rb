class Deputado < ActiveRecord::Base

  has_many :despesas

  searchable do
  	text :nome, :partido, :matricula, :url_foto, :email, :uf
  	text :despesas do
  		despesas.map { |despesa| [despesa.beneficiario, despesa.cpf_cnpj] }
  	end
  end

  scope :com_total_despesas, -> {
     joins("LEFT JOIN despesas ON despesas.deputado_id = deputados.id")
    .select('deputados.*', 'sum(despesas.valor_liquido) as total_despesas')
    .group('deputados.nome')
  }

  scope :partidos, -> {
    select('distinct(partido), count(*) as quantidade')
    .group('deputados.partido')
    .map do |deputado|
      {
        :nome       => deputado.partido,
        :quantidade => deputado.quantidade
      }
   end
  }

  scope :aleatorios,       -> { com_total_despesas.order('RAND()')              }
  scope :com_despesas,     -> { com_total_despesas.includes(:despesas)          }
  scope :maiores_despesas, -> { com_total_despesas.order('total_despesas desc') }
  scope :top_tres,         -> { aleatorios.limit(3)                             }


  def self.buscar(query)
    hits           = self.search { fulltext query }.hits
    deputados_ids  = hits.map { |hit| hit.primary_key }

    # Busca por ID os registros encontrados pela busca
    self.maiores_despesas.where(id: (deputados_ids))
  end


  def self.todos(query, current_page, per_page = 10)
    deputados = query.blank? ? self.maiores_despesas : self.buscar(query)
    deputados.paginate(:page => current_page, :per_page => per_page)
  end


  def data_ultima_atualizacao
    !despesas.empty? ? despesas.mais_novos.first.updated_at : updated_at
  end

end