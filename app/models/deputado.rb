class Deputado < ActiveRecord::Base

  has_many :despesas
  
  scope :com_despesas, -> { 
     joins(:despesas) 
    .select('*', 'sum(despesas.valor_liquido) as total_despesas')
    .group('deputados.nome')
  }

  scope :maiores_despesas, -> {
    com_despesas.order('total_despesas desc')
  }

end
