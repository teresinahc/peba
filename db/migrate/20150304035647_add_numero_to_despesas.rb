class AddNumeroToDespesas < ActiveRecord::Migration
  def change
    add_column :despesas, :numero, :string
  end
end
