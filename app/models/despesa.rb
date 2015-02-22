class Despesa < ActiveRecord::Base
  
  scope :total_gasto, -> { sum(:valor_liquido) }
  scope :mais_novos,  -> { order(:data_emissao) }

  belongs_to :deputado

end
