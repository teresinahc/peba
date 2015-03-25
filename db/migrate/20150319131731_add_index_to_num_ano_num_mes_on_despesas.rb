class AddIndexToNumAnoNumMesOnDespesas < ActiveRecord::Migration
  def change
    add_index :despesas, [:num_ano, :num_mes]
  end
end
