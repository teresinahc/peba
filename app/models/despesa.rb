class Despesa < ActiveRecord::Base

  belongs_to :deputado

  scope :total_gasto,        -> { sum(:valor_liquido) }
  scope :mais_novos,         -> { order('data_emissao desc') }
  scope :por_classificacao,  -> (classificacao) { where(:descricao => classificacao) }

  scope :classificacoes, -> {
    select("distinct(descricao)").map { |classificacao| classificacao.descricao }
  }

  scope :totais_por_descricao, -> {
    select("descricao,sum(valor_liquido) as total_liquido,sum(valor_documento) as total")
    .group("descricao")
    .map do |despesa|
      {
        :descricao     => despesa.descricao,
        :total_liquido => despesa.total_liquido,
        :total         => despesa.total
      }
    end
  }

  def self.todos(query, current_page, per_page = 20)
    mais_novos.paginate(:page => current_page, :per_page => per_page)
  end

  def self.por_filtro(filtro)
    mais_novos.where(filtro)
  end

  def self.por_mes
    total = Despesa.select('num_ano, num_mes').group([:num_ano, :num_mes]).having('num_ano > 0').total_gasto
    total.group_by{|key, value| key[0] } # agrupar por ano
  end
end
