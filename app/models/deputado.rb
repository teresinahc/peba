class Deputado < ActiveRecord::Base

  has_many :despesas

  scope :maiores_despesas, -> { 
     joins(:despesas) 
    .select('deputados.id', 'deputados.nome', 'sum(despesas.valor_liquido) as total_despesas')
    .group('deputados.nome')
    .order('total_despesas desc')
  }

end
