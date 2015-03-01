class Despesa < ActiveRecord::Base
  
  scope :total_gasto, -> { sum(:valor_liquido) }
  scope :tipos, -> { select("distinct(descricao)").map { |despesa| despesa.descricao } }
  scope :totais_por_descricao, -> { 
  	select("descricao,sum(valor_liquido) as total_liquido,sum(valor_documento) as total")
  	.group("descricao")
  	.map do |despesa|
  		{
  			:descricao=>despesa.descricao,
  			:total_liquido=>despesa.total_liquido,
  			:total => despesa.total
  		}
  	end
  }
  scope :mais_novos,  -> { order('data_emissao desc') }
  scope :por_descricao,  ->(descricao) { where(:descricao=>descricao) }

  belongs_to :deputado

  def self.todos(query, current_page, per_page = 20)
    mais_novos.paginate(:page => current_page, :per_page => per_page)
  end

 
end
