class AddDescricaoToDespesas < ActiveRecord::Migration
  def change
    add_column :despesas, :descricao, :string
  end
end
