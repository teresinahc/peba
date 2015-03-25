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


  # retorna gastos anuais mes a mes
  def self.mensal
    default = Hash[(1..12).collect {|n| [n, nil]}]

    total = Despesa.group([:num_ano, :num_mes]).having('num_ano > 0').total_gasto

    # output = [{ano1 => {mes1 => valor, mes2 => valor, ...}}, {ano2 => {mes1 => valor, ...}}]
    total.group_by{|key, value| key[0] }.map do |ano, valores|
      { ano => default.merge(Hash[valores.collect {|mes, valor| [mes[1], valor.to_f]}]) }
    end
  end


  # retorna gastos anuais
  def self.anual
    Despesa.group(:num_ano).having('num_ano > 0').total_gasto
  end
end
