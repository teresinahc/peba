class AddUfToDeputados < ActiveRecord::Migration
  def change
    add_column :deputados, :uf, :string
  end
end
