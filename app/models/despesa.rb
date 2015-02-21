class Despesa < ActiveRecord::Base
  scope :total_gasto, -> { sum(:valor_liquido) }
  belongs_to :deputado
end
