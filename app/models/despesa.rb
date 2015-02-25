class Despesa < ActiveRecord::Base
  
  scope :total_gasto, -> { sum(:valor_liquido) }
  scope :mais_novos,  -> { order(:data_emissao) }

  belongs_to :deputado

  def self.todos(query, current_page, per_page = 10)
    mais_novos.paginate(:page => current_page, :per_page => per_page)
  end

end
