class AddColumnNomeParlamentarToDespesa < ActiveRecord::Migration
  def change
    add_column :despesas, :nome_parlamentar, :string
  end
end
