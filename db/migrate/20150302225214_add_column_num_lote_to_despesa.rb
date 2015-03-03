class AddColumnNumLoteToDespesa < ActiveRecord::Migration
  def change
    add_column :despesas, :num_lote, :integer
    add_column :despesas, :num_ressarcimento, :integer
    add_column :despesas, :num_sub_cota, :integer
    add_column :despesas, :num_especificacao_sub_cota, :integer
  end
end
