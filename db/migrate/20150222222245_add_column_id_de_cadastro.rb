class AddColumnIdDeCadastro < ActiveRecord::Migration
  def change
  	add_column :deputados, :id_cadastro, :integer
  end
end
