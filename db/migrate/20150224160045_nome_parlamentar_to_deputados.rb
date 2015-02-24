class NomeParlamentarToDeputados < ActiveRecord::Migration
  def change
    add_column :deputados, :nome_parlamentar, :string
  end
end
