class AddNuDeputadoIdToDespesas < ActiveRecord::Migration
  def change
    add_column :despesas, :nu_deputado_id, :integer
  end
end
