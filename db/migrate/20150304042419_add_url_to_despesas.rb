class AddUrlToDespesas < ActiveRecord::Migration
  def change
    add_column :despesas, :url_recibo, :string
  end
end
