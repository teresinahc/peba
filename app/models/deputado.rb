class Deputado < ActiveRecord::Base
   has_many :despesas
   
   def total_despesa
 	@total_gasto = despesas.total_gasto
   end
end
