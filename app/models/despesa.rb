class Despesa < ActiveRecord::Base
  
  include ActionView::Helpers::NumberHelper

  scope :total_gasto, -> { sum(:valor_liquido) }
  scope :mais_novos,  -> { order(:data_emissao) }

  belongs_to :deputado

  def total_valor_liquido
    number_to_currency(valor_liquido)
  end

end
