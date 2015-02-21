class Deputado < ActiveRecord::Base
  
  include ActionView::Helpers::NumberHelper

  has_many :despesas
  
  scope :com_total_despesas, -> { 
     joins(:despesas) 
    .select('*', 'sum(despesas.valor_liquido) as total_despesas')
    .group('deputados.nome')
  }

  scope :com_despesas, -> {
    com_total_despesas.includes(:despesas)
  }

  scope :maiores_despesas, -> {
    com_total_despesas.order('total_despesas desc')
  }

  def total_despesas_formatado
    number_to_currency(total_despesas)
  end

end
